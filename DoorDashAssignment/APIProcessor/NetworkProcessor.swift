//
//  NetworkProcessor.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

typealias RestaurantListResponse = (_ restaurants: [Restaurant]?, _ error: Error?) -> Void

final class NetworkProcessor {
    static let shared = NetworkProcessor()
    private init() { }
    
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    //https://api.doordash.com/v1/store_search/?lat=37.42274&lng=-122.139956
    func getRestaurants(lat: Double, lng: Double, completion: @escaping RestaurantListResponse) {
        let searchRestaurantsURLString = Constants.API.rootURL + Constants.API.storeSearch
       dataTask?.cancel()
        if var urlComponents = URLComponents(string: searchRestaurantsURLString) {
            let latQueryItem = URLQueryItem(name: "lat", value: String(describing: lat))
            let lngQueryItem = URLQueryItem(name: "lng", value: String(describing: lng))

            urlComponents.queryItems = [latQueryItem, lngQueryItem]
            
            guard let url = urlComponents.url else { return }
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                defer { self.dataTask = nil }
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Error during fetching search results for Restaurans = \(String(describing: error?.localizedDescription))\n")
                        completion(nil, nil)
                        return
                }
                do{
                    let result = try JSONDecoder().decode([Restaurant].self, from: data)
                    completion(result, nil)
                } catch let error {
                    print("Error: Couldn't decode data into [Restaurant] = \(error.localizedDescription)\n")
                    completion(nil, error)
                }
            })
        }
       
    }
    
}
