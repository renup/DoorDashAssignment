//
//  Constants.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

/// App related constants
struct Constants {
    struct Colors {
        static let base = UIColor(red: 255.0/255.0, green: 0/255.0, blue: 36.0/255.0, alpha: 1)
    }
    
    struct API {
        static let rootURL = "https://api.doordash.com/"
        static let storeSearch = "v1/store_search/"
    }
}
