//
//  Enums.swift
//  set-game
//
//  Created by hridayam bakshi on 2/9/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

enum Count: Int, EnumCollection {
    case one = 1
    case two = 2
    case three = 3
}

enum Characters: String, EnumCollection {
    case square = "\u{25A0}"
    case circle = "\u{25CF}"
    case triangle = "\u{25B2}"
}

enum Shading: EnumCollection {
    case open
    case striped
    case solid
}

enum Color: EnumCollection {
    case red
    case green
    case purple
}

protocol EnumCollection : Hashable {}
extension EnumCollection {
    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}
