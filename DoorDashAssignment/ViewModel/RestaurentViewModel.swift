//
//  RestaurentViewModel.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

/// This class is the mediator between view and API layer. View class talks to this class which further reaches out to API layer. API layer passes response to this class which is further passed back to the View layer
final class RestaurantViewModel: NSObject {
    
    /// Fetches Restaurants list for given coordinate
    ///
    /// - Parameters:
    ///   - lat: Latitude for the location we are seeking the list of restaurants
    ///   - lng: Longitude for the location we are seeking the list of restaurants
    ///   - completion: Completion handler for the api response received from the fetch call
    static func fetchRestaurantListForGivenCoordinates(lat: String, lng: String, completion: @escaping RestaurantListResponse) {
        NetworkProcessor.shared.getRestaurants(lat: lat, lng: lng) { (restaurants, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completion(restaurants, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    
    /// Fetches image
    ///
    /// - Parameters:
    ///   - urlString: image url in String format
    ///   - completion: completion handler for image fetch call
    static func fetchImage(urlString: String, completion: @escaping ImageResponse) -> URLSessionTask? {
        
       return NetworkProcessor.shared.getImage(urlString: urlString) { (image, error) in
            DispatchQueue.main.async {
                if image != nil {
                    completion(image, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
}
