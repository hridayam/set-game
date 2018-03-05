//
//  ViewController.swift
//  set-game
//
//  Created by Rooh on 2/9/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    //initializing variables
    var game: Game = Game()
    //var cardModel: CardsModel = CardsModel()
    var selectedButtons: [Int] = []
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var visibleCards: Int = 0
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //selects and deselects a card and calls match cards to check if cards match
    @IBAction func selectCard(_ sender: UIButton) {
        let index = cardButtons.index(of: sender)
        
        if index! >= game.getNumPlayableCards() {
            return
        }
        
        if selectedButtons.count == 3 {
            deselctAll()
        }
        
        game.selectCard(index: index!)
        selectDeselect(index: index!)
        matchCards()
        score = game.getScore()
    }
    
    // deselects all when newgame or 3 non matching cards are selected
    func deselctAll() {
        for i in 0..<selectedButtons.count {
            cardButtons[selectedButtons[i]].layer.borderWidth = 0.0
            cardButtons[selectedButtons[i]].layer.borderColor = UIColor.clear.cgColor
            cardButtons[selectedButtons[i]].layer.cornerRadius = 0.0
        }
        selectedButtons.removeAll()
    }
    
    //selects deselected card and vice versa
    func selectDeselect(index: Int) {
        for i in 0..<selectedButtons.count {
            if selectedButtons[i] == index {
                cardButtons[index].layer.borderWidth = 0.0
                cardButtons[index].layer.borderColor = UIColor.clear.cgColor
                cardButtons[index].layer.cornerRadius = 0.0
                selectedButtons.remove(at: i)
                return
            }
        }
        
        cardButtons[index].layer.borderWidth = 3.0
        cardButtons[index].layer.borderColor = UIColor.cyan.cgColor
        cardButtons[index].layer.cornerRadius = 7.0
        selectedButtons.append(index)
    }
    
    // matches cards if 3 cards selected
    func matchCards() {
        if selectedButtons.count < 3 {
            return
        }
        if game.equals() {
            deselctAll()
            loadUI()
        }
    }
    
    //adds 3 cards
    @IBAction func addCards(_ sender: Any) {
        if visibleCards >= 24 {
            return
        }
        game.addMoreCards()
        loadUI()
    }
    
    // refreshes the game
    @IBAction func newGame(_ sender: Any) {
        game = Game()
        score = 0
        deselctAll()
        loadUI()
    }
    
    // loads cards into buttons and removes the old ones
    func loadUI() {
        visibleCards = 0
        for i in 0..<cardButtons.count {
            if game.getCard(index: i) != nil {
                var temp: String = ""
                var color: UIColor
                var strokeColor: UIColor
                var attributes: [NSAttributedStringKey: Any]
                var stroke: Int
                
                for _ in 0..<game.getCard(index: i)!.count {
                    temp.append(game.getCard(index: i)!.character)
                }
                
                if temp.count == 2 {
                    cardButtons[i].titleLabel?.font = cardButtons[i].titleLabel?.font.withSize(40)
                }
                if temp.count == 3 {
                    cardButtons[i].titleLabel?.font = cardButtons[i].titleLabel?.font.withSize(29)
                }
                
                if game.getCard(index: i)!.color == "green" {
                    color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                } else if game.getCard(index: i)!.color == "blue" {
                    color = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                } else {
                    color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
                
                strokeColor = color
                if game.getCard(index: i)!.shading == Shading.open {
                    stroke = 5
                    color = color.withAlphaComponent(0)
                } else if game.getCard(index: i)!.shading == Shading.striped {
                    stroke = -5
                    color = color.withAlphaComponent(0.35)
                } else {
                    stroke = 0
                    color = color.withAlphaComponent(1)
                }
                
                attributes = [NSAttributedStringKey.strokeWidth : stroke, NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.strokeColor: strokeColor]
                let attributedString = NSAttributedString(string: temp, attributes: attributes)
                
                cardButtons[i].backgroundColor = #colorLiteral(red: 1, green: 0.994028257, blue: 0.9217744457, alpha: 1)
                cardButtons[i].setAttributedTitle(attributedString, for: UIControlState.normal)
                visibleCards += 1
                //cardModel.printCards(cards: [game.getCard(index: i)!])
                
            } else {
                cardButtons[i].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                cardButtons[i].setAttributedTitle(nil, for: UIControlState.normal)
                cardButtons[i].setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadUI()
        /*print("\nplayable cards\n")
        cards.printCards(cards: cards.playableCards)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

