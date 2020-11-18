//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Heli Bavishi on 11/17/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var vauleLabel: UILabel!
    @IBOutlet weak var suitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchImageAndUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let image):
                    self?.vauleLabel.text = card.value
                    self?.suitLabel.text = card.suit
                    self?.cardImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
