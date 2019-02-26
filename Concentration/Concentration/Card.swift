//
//  Card.swift
//  Concentration
//
//  Created by James Stacy on 2/19/19.
//  Copyright © 2019 James Stacy. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return identifier}
    
    static func ==(lhs:Card, rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = true
    var isMatched = false
   private var identifier: Int
    
   private static var identifierFactory = 0
    
   private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    
    mutating func resetCard() {
        isFaceUp = false
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
