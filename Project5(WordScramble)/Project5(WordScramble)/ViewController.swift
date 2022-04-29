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
    @objc func promptAnwer () { // call anser
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
        
    }
    
}

