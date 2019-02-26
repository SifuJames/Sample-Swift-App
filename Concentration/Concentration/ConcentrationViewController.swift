//
//  ViewController.swift
//  Concentration
//
//  Created by James Stacy on 2/19/19.
//  Copyright © 2019 James Stacy. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

   private lazy var game = Consentration(numberOfPairsOfCards:numberOfPairsOfCards)
    
   public var numberOfPairsOfCards: Int {
        return (cardButtons.count / 2)
    }
    
   private(set) var flipCount = 0 {
        didSet {
           updateFlipCountLabel()
    }}
    
    private func updateFlipCountLabel() {
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.red
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    
    @IBOutlet weak var bestLabel: UILabel!
    

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if sender.backgroundColor ==  #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0) {
            
        }else if  waitingForTimer {
            
        }else{
        
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            
        upDateViewFromModel()
            print("Update from model called")
        }else{
            print("Card not in series")
        }
        
        }}
    
    var waitingForTimer = false
    var cardCounter = 0
    
    var matches = 0 {
        didSet{
            bestLabel.text = "\(matches)"
            if matches == 10 {
                endGame()
            }
        }
    }
    var bestScore:Int = 1000
    {
        didSet {
            bestLabel.text = "Best\n\(bestScore)"
            UserDefaults.standard.set(bestScore, forKey: "Score")
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         bestScore = UserDefaults.standard.object(forKey:"Score") as? Int ?? 1000
    }
    
    
    
   private func upDateViewFromModel() {
         print("Update from model here")
    if cardButtons != nil {
   cardCounter += 1
    var yes = false
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
                if card.isMatched && card.isFaceUp {
                    yes = true
            }
            
            
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        
        }
    
    if yes {
        matches += 1
        yes = false
    }

    if cardCounter >= 2 {
        cardCounter = 0
        waitingForTimer = true
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(resetAllCards), userInfo: nil, repeats: false)
    }
    
    }}
    
  @objc  func resetAllCards() {
  
    waitingForTimer = false
    game.resetCards()
      for index in cardButtons.indices {
        let button = cardButtons[index]
        let card = game.cards[index]
        button.setTitle("", for: .normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    if matches >= 10 {
//        let holdMe = bestScore
//        if flipCount < bestScore {
            bestScore = flipCount
//        }else{
//            bestScore =  holdMe
//        }
        endGame()
    }
    }
    
    func endGame() {
        print("Ran end game \(bestScore)")
        // save high score
    }
    

    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            upDateViewFromModel()
        }
    }
   
    var emojiChoices = ""
    var emogiHolder = ""
    
    private var emoji = [Card:String]()
    
   private func emoji(for card: Card) ->String {
        if emoji[card] == nil , emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = "\(emojiChoices.remove(at:randomStringIndex))"
            }
    print("emoji info \(card) \(emoji.count)")
     return emoji[card] ?? "?"
        }
    
 

    @IBAction private func resetAction() {
        if matches < bestScore {
            bestScore = matches
            matches = 0
        }
        flipCount = 0
        emojiChoices = "👻💀☠️👽🎃🤡👹💩🤠🤖😈👺"
        game = Consentration(numberOfPairsOfCards: cardButtons.count / 2)
        for check in cardButtons {
            check.setTitle("", for: .normal)
            check.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }
    
}


extension Int {
    var arc4Random: Int {
        if self > 0 {
            return  Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
