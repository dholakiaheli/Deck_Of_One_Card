//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Heli Bavishi on 11/17/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        let deckComponent = "new/draw"
        let cardCountComponent = "count"
        // 1 - Prepare URL
        guard let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/") else { return completion(.failure(.invalidURL)) }
        let cardURL = baseURL.appendingPathComponent(deckComponent)
        
        var components = URLComponents(url: cardURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: cardCountComponent, value: "1")]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: finalURL) { (data, _ ,error) in
            
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for json data
            guard let data = data else { return completion(.failure(.noData))}
            
            // 5 - Decode json into a Card
            do {
                let toplevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = toplevelObject.cards.first else { return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
        // 1 - Prepare URL
        let url = card.image
        // 2 - Contact server
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for image data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Initialize an image from the data
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            return completion(.success(image))
            
        }.resume()
    }
}

