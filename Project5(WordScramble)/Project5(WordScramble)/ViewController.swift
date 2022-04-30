//
//  ViewController.swift
//  Project5(WordScramble)
//
//  Created by Alfin on 28/4/22.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAnswer))
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    @objc func promptAnswer () { // call anser
        let ac = UIAlertController(title: "enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField() //add new textbox to ui controller
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {  //trailing closure syntax
            [weak self, weak ac] _ in // specifies input to closure. closure must weak reference cause might be nil . the important is "in" after "in" is a body closure
            guard let answer = ac?.textFields?[0].text else { return } //ac is optional might exist and index 0 must text field
            self?.submit(answer) // try call submit to strong self
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        if isPossible(word: lowerAnswer) {
            if isOriginal (word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return // exit so it will not run ac
                } else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up"
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You cant spell that from \(title!.lowercased())."
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default ))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    func isOriginal(word: String) -> Bool {
        let checker = UITextChecker ()
        let range = NSRange(location: 0, length: word.utf16.count) //uikit use utf16 because written in obj c use in spritekit and other kit
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en") // look at the first paramater and second other is just to complete
        return misspelledRange.location == NSNotFound // (NSNotfound telling you word is spelled correctly )
         
    }
}

