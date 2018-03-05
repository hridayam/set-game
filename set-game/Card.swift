//
//  Card.swift
//  set-game
//
//  Created by hridayam bakshi on 2/9/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

struct Card: Equatable {
    
    let count: Count
    let symbol: Characters
    let shading: Shading
    let color: Color
    
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return(lhs.count == rhs.count && lhs.symbol == rhs.symbol && lhs.color == rhs.color && lhs.shading == rhs.shading)
    }
}
