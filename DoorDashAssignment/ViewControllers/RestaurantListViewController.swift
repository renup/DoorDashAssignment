//
//  RestaurantListViewController.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var restaurants: [Restaurant] = [] {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantViewModel.fetchRestaurantListForGivenCoordinates(lat: latitude, lng: longitude) { (restaurants, error) in
            if error == nil {
                guard let result = restaurants else { return }
                self.restaurants = result
            } else {
                self.showError("Opps! problem getting Restaurants", message: "There was a problem getting the list of restaurants around you")
            }
        }
    }
    
}

extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension RestaurantListViewController: UITableViewDelegate {
    
}
