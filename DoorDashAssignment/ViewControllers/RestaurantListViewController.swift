//
//  RestaurantListViewController.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit
import MapKit

/// This class displays retaurants list based on the location selected in previous map view scene.
class RestaurantListViewController: UIViewController {
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    struct RestaurantListConstants {
        static let cellIdentifier = "restaurantCell"
        
        struct FetchRestaurantsError {
            static let title = "Oops! problem getting Restaurants"
            static let message = "There was a problem getting the list of restaurants. Please try again in few mins"
        }
    }
    
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    var restaurants: [Restaurant] = [] {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRestaurantListScene()
        fetchRestaurantsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.navigationController?.navigationBar.tintColor = Constants.Colors.base
        let textAttributes = [NSAttributedString.Key.foregroundColor: Constants.Colors.base]
        parent?.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.parent?.title = "DoorDash"
    }
    
    //MARK: Private methods
    private func setUpRestaurantListScene() {
        restaurantTableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: RestaurantListConstants.cellIdentifier)
        
    }
    
    
    
    private func fetchRestaurantsList() {
        RestaurantViewModel.fetchRestaurantListForGivenCoordinates(lat: String(describing: latitude), lng: String(describing: longitude)) { (restaurants, error) in
            if error == nil {
                guard let result = restaurants else { return }
                self.restaurants = result
            } else {
                self.showError(RestaurantListConstants.FetchRestaurantsError.title, message: RestaurantListConstants.FetchRestaurantsError.message)
            }
        }
    }
}

//MARK: UITableViewDataSource methods
extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListConstants.cellIdentifier) as! RestaurantCell
        cell.configureCell(restaurant: restaurants[indexPath.row])
        return cell
    }
    
    
}

//MARK: UITableViewDelegate methods
extension RestaurantListViewController: UITableViewDelegate {
    //TODO: Yet to be implemented based on requirements
}
