//
//  Game.swift
//  set-game
//
//  Created by hridayam bakshi on 2/14/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

class Game {
    private var selectedCards: [Card] = []
    private var cardsModel: CardsModel
    private var score: Int
    private var currentCards: [Card]
    
    init() {
        cardsModel = CardsModel()
        score = 0
        currentCards = cardsModel.getPlayableCards()
    }
    
    // select 1 card
    func selectCard(index: Int) {
        //Deselect condition
        for i in 0..<selectedCards.count {
            if selectedCards[i] == currentCards[index] {
                selectedCards.remove(at: i)
                score -= 1
                return
            }
        }
        
        if selectedCards.count > 3 {
            return
        }
        
        selectedCards.append(currentCards[index])
    }
    
    // returns score
    func getScore() -> Int {
        return score
    }
    
    // returns current in game cards
    func getNumPlayableCards() -> Int {
        return currentCards.count
    }
    
    func getCard(index: Int) -> Card? {
        if index < currentCards.count && index >= 0 {
            return currentCards[index]
        }
        else {
            return nil
        }
    }
    
    // checks if 3 cards match according to rules
    func equals() -> Bool {
        var retVal: Bool = false
        if selectedCards.count == 0 {
            return retVal
        }
        
        if checkColor(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
            if checkShade(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
                if checkCount(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
                    if checkSymbol(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
                        retVal = true
                        cardsModel.replaceCards(selectedCards: selectedCards)
                        currentCards = cardsModel.getPlayableCards()
                    }
                }
            }
        }
        
        if retVal {
            score += 3
        }
        else {
            score -= 4
        }
        selectedCards.removeAll()
        return retVal
    }
    
    func addMoreCards() {
        cardsModel.loadNextThreePlayableCards()
        currentCards = cardsModel.getPlayableCards()
    }
    
    //Private functions to match cards
    private func checkColor(card1: Card, card2: Card, card3: Card)-> Bool {
        var retVal: Bool = false
        if(card1.color == card2.color &&
            card1.color == card3.color) {
            retVal = true
        } else if(card1.color != card2.color &&
            card1.color != card3.color &&
            card2.color != card3.color) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
    private func checkShade(card1: Card, card2: Card, card3: Card) -> Bool {
        var retVal: Bool = false
        if(card1.shading == card2.shading &&
            card1.shading == card3.shading) {
            retVal = true
        } else if(card1.shading != card2.shading &&
            card1.shading != card3.shading &&
            card2.shading != card3.shading) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
    private func checkCount(card1: Card, card2: Card, card3: Card) -> Bool {
        var retVal: Bool = false
        if(card1.count == card2.count &&
            card1.count == card3.count) {
            retVal = true
        } else if(card1.count != card2.count &&
            card1.count != card3.count &&
            card2.count != card3.count) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
    private func checkSymbol(card1: Card, card2: Card, card3: Card) -> Bool {
        var retVal: Bool = false
        if(card1.symbol == card2.symbol &&
            card1.symbol == card3.symbol) {
            retVal = true
        } else if(card1.symbol != card2.symbol &&
            card1.symbol != card3.symbol &&
            card2.symbol != card3.symbol) {
            retVal = true
        } else {
            retVal = false
        }
        return retVal
    }
}
