//
//  RestaurantCell.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

/// This class will manage configuring Restaurant cell
final class RestaurantCell: UITableViewCell {
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    var dataTask: URLSessionTask?
    
    /// Configure the RestaurantCell using Restaurant object
    ///
    /// - Parameter restaurant: restaurant object which will be utilized to populate the restaurant cell with relevant info
    func configureCell(restaurant: Restaurant) {
        coverImageView.image = UIImage(named: "food_icon")
        if let imageURLString = restaurant.coverImageURLString {
         dataTask = RestaurantViewModel.fetchImage(urlString: imageURLString) { (img, error) in
                if let image = img {
                    self.coverImageView.image = image
                }
            }
        }
        
        if let deliveryFee = restaurant.deliveryFee {
            if deliveryFee == 0 {
                deliveryFeeLabel.text = "Free delivery"
            } else {
                deliveryFeeLabel.text = deliveryFee.convertIntoCurrency() + " delivery"
            }
        } else {
            deliveryFeeLabel.text = "No data found"
        }
        
        if let asapTime = restaurant.asapTime {
            deliveryTimeLabel.text = String(describing: asapTime) + " min"
        } else {
            deliveryTimeLabel.text = "No data found"
        }
        
        if let cuisineDes = restaurant.description {
            cuisineTypeLabel.text = cuisineDes
        } else {
            cuisineTypeLabel.text = "No data found"
        }
        if let business = restaurant.business, let name = business.name {
            restaurantNameLabel.text = name
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        resetValues()
    }
    
    private func resetValues() {
        deliveryFeeLabel.text = nil
        deliveryTimeLabel.text = nil
        coverImageView.image = nil
        restaurantNameLabel.text = nil
        cuisineTypeLabel.text = nil
    }
    
}


