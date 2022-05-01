//
//  ViewController.swift
//  Project2(GuessFlag)
//
//  Created by Alfin on 24/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let label1 = UILabel()
           label1.translatesAutoresizingMaskIntoConstraints = false
           label1.backgroundColor = UIColor.red
           label1.text = "THESE"
           label1.sizeToFit()

           let label2 = UILabel()
           label2.translatesAutoresizingMaskIntoConstraints = false
           label2.backgroundColor = UIColor.cyan
           label2.text = "ARE"
           label2.sizeToFit()

           let label3 = UILabel()
           label3.translatesAutoresizingMaskIntoConstraints = false
           label3.backgroundColor = UIColor.yellow
           label3.text = "SOME"
           label3.sizeToFit()

           let label4 = UILabel()
           label4.translatesAutoresizingMaskIntoConstraints = false
           label4.backgroundColor = UIColor.green
           label4.text = "AWESOME"
           label4.sizeToFit()

           let label5 = UILabel()
           label5.translatesAutoresizingMaskIntoConstraints = false
           label5.backgroundColor = UIColor.orange
           label5.text = "LABELS"
           label5.sizeToFit()

           view.addSubview(label1)
           view.addSubview(label2)
           view.addSubview(label3)
           view.addSubview(label4)
           view.addSubview(label5)
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
  }
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer=Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // dispose memory
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1 }
        else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction( title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}
