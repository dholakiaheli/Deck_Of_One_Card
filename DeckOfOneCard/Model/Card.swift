//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Heli Bavishi on 11/17/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let value : String
    let suit: String
    let image: URL
}
