//
//  FavoritesListViewController.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/21/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

/// This class displays retaurants favorited by user
class FavoritesListViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.title = "Favorites"
    }
    
}
