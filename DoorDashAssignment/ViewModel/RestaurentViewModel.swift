//
//  RestaurentViewModel.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

class RestaurantViewModel: NSObject {
    static let shared = RestaurantViewModel()
    
    static func fetchRestaurantListForGivenCoordinates(lat: Double, lng: Double, completion: @escaping RestaurantListResponse) {
        NetworkProcessor.shared.getRestaurants(lat: lat, lng: lng) { (restaurants, error) in
            if error == nil {
                completion(restaurants, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
