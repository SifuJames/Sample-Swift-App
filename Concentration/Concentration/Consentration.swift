//
//  Consentration.swift
//  Concentration
//
//  Created by James Stacy on 2/19/19.
//  Copyright © 2019 James Stacy. All rights reserved.
//

import Foundation

class Consentration  {
    
    private(set) var cards =  [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard:Int?{
        get {
         return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set(newValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
   
  
    
    func chooseCard(at index: Int) {
        print("Card Choosen \(index)")
        assert(cards.indices.contains(index), "Concentration.ChooseCard(as: \(index)): Choosen index is not in the cards")
        if !cards[index].isMatched {
           
            if let matchINdex = indexOfOneAndOnlyFaceUpCard, matchINdex != index {
                if cards[matchINdex] == cards[index] {
                    cards[matchINdex].isMatched = true
                    cards[index].isMatched = true
                }else{
                   print("Reset Here")
                }
                cards[index].isFaceUp = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
      }
    
    func resetCards() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        
         assert(numberOfPairsOfCards > 0, "Concentration.init \(numberOfPairsOfCards) you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
        let card = Card()
            cards += [card,card]
        }
        // TODO: Shuffle Cards
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
