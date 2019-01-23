//
//  Restaurent.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case asapTime = "asap_time"
        case deliveryFee = "delivery_fee"
        case coverImageURLString = "cover_img_url"
        case business
    }
    
     var asapTime : Int
     var deliveryFee: Double
     var coverImageURLString: String
     var business: Business
}

class Business: Decodable {
    var name: String
}
