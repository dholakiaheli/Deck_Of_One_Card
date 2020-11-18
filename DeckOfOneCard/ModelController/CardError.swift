//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Heli Bavishi on 11/17/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    /// Whatever info you think the user should know.
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return error.localizedDescription
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
