//
//  ViewController.swift
//  apple
//
//  Created by Vithika on 10/19/22.
//

import UIKit

var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]

let incorrectMovesAllowed = 7

class ViewController: UIViewController {

    var totalWins = 0{
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    
    @IBOutlet weak var treeimageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterbutton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    
    var currentGame: Game!

    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                enableLetterButtons(true)
                updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterbutton {
            button.isEnabled = enable
        }
       }
    
    func updateUI() {
        var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeimageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        } else{
            updateUI()
        }
    }
    
}

