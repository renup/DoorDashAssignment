//
//  NetworkProcessor.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

typealias RestaurantListResponse = (_ restaurants: [Restaurant]?, _ error: Error?) -> Void

typealias ImageResponse = (_ image: UIImage?, _ error: Error?) -> Void

/// This is the API layer which makes the actual requests and gets response
final class NetworkProcessor {
    static let shared = NetworkProcessor()
    private init() { }
    
    let imageCache = NSCache<NSString, AnyObject>()
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    
    // Example: https://api.doordash.com/v1/store_search/?lat=37.42274&lng=-122.139956
    /// Fetches Restaurants list for the requested coordinates
    ///
    /// - Parameters:
    ///   - lat: latitude in string format
    ///   - lng: longitude in string format
    ///   - completion: completion handler for response received from api call
    func getRestaurants(lat: String, lng: String, completion: @escaping RestaurantListResponse) {
        let searchRestaurantsURLString = Constants.API.rootURL + Constants.API.storeSearch
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: searchRestaurantsURLString) {
            let latQueryItem = URLQueryItem(name: "lat", value: lat)
            let lngQueryItem = URLQueryItem(name: "lng", value: lng)
            
            urlComponents.queryItems = [latQueryItem, lngQueryItem]
            
            guard let url = urlComponents.url else { return }
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                defer { self.dataTask = nil }
                if let err = error {
                    completion(nil, err)
                } else if let data = data {
                    do{
                        let result = try JSONDecoder().decode([Restaurant].self, from: data)
                        completion(result, nil)
                    } catch let error {
                        #if DEBUG
                        print("Error: Couldn't decode data into [Restaurant] = \(error.localizedDescription)\n")
                        #endif
                        completion(nil, error)
                    }
                } else {
                    completion(nil, error)
                }
            })
        }
        dataTask?.resume()
        
    }
    
    /// Gets image for requested url
    ///
    /// - Parameters:
    ///   - urlString: url String for image
    ///   - completion: completion handler for response received from the api call
    func getImage(urlString: String, completion: @escaping  ImageResponse) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage, nil)
            return
        }
        
        dataTask?.cancel()
        
        guard let url = URL(string: urlString) else {
            #if DEBUG
            print("Invalid image url string found during fetching image")
            #endif
            return
        }
        
        dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            defer { self.dataTask = nil }
            
            if let error = error {
                completion(nil, error)
            } else if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                completion(image, nil)
            } else {
                completion(nil, error)
            }
        })
        dataTask?.resume()
    }
    
}
