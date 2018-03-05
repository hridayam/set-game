//
//  CardsModel.swift
//  set-game
//
//  Created by hridayam bakshi on 2/9/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

class CardsModel {
    var cards = [Card]()
    var playableCards = [Card]()
    
    init() {
        loadCards()
        loadFirstPlayableCards()
    }
    
    // loads all 81 possible cards
    private func loadCards() {
        for i in 0...Count.three.hashValue {
            for j in 0...Characters.triangle.hashValue {
                for k in 0...Shading.solid.hashValue {
                    for l in 0...Color.purple.hashValue {
                        cards.append(
                            Card(count: Array(Count.cases())[i],
                                 symbol: Array(Characters.cases())[j],
                                 shading: Array(Shading.cases())[k],
                                 color: Array(Color.cases())[l])
                        )
                    }
                }
            }
        }
    }
    
    //load first 12 playable cards into playableCards
    private func loadFirstPlayableCards() {
        for _ in 0..<12 {
            playableCards.append(loadOneCard())
        }
    }
    
    // loads next 3 playable cards
    func loadNextThreePlayableCards() {
        if cards.count < 3 {
            return
        }
        
        for _ in 0..<3 {
            if playableCards.count < 24 || cards.count > 0 {
                playableCards.append(loadOneCard())
            }
            else {
                return
            }
        }
    }
    
    // called to load only one card. used by loadFirstCards and loadNexTthree
    private func loadOneCard() -> Card {
        let randCard = cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
        return randCard
    }
    
    //returns all non playable cards
    func getCards() -> [Card] {
        return cards
    }
    //returna all playable cards
    func getPlayableCards() -> [Card] {
        return playableCards
    }
    
    //replaces cards in playable from non playable if supplied cards match
    func replaceCards(selectedCards: [Card]){
        if cards.count < 3 {
            removeCards(selectedCards: selectedCards)
            return
        }
        
        for i in 0..<playableCards.count {
            for j in 0..<selectedCards.count {
                if playableCards[i] == selectedCards[j] {
                    playableCards.remove(at: i)
                    playableCards.insert(loadOneCard(), at: i)
                }
            }
        }
    }
    
    // removes if cards match
    func removeCards(selectedCards: [Card]) {
        
        for j in 0..<selectedCards.count {
            for i in 0..<playableCards.count {
                if playableCards[i] == selectedCards[j] {
                    playableCards.remove(at: i)
                    break
                }
            }
        }
    }
    
    //prints cards
    func printCards(cards: [Card]) {
        for i in 0..<cards.count {
            print("\(cards[i].color) \(cards[i].count.rawValue) \(cards[i].shading) \(cards[i].symbol.rawValue)")
        }
        print(cards.count)
    }
}
