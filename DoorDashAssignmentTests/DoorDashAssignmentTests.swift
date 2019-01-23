//
//  DoorDashAssignmentTests.swift
//  DoorDashAssignmentTests
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import XCTest
@testable import DoorDashAssignment
import Mockingjay

class DoorDashAssignmentTests: XCTestCase {
    
    func testRestaurantSearchRequestStubWithMockingjay() {
        guard let restaurantSearchUrl = URL(string: "https://api.doordash.com/v1/store_search/?lat=37.42274&lng=-122.139956") else { return }
        
        let path = Bundle(for: type(of: self)).path(forResource: "DoorDashResponse", ofType: "json")!
        
        let data = NSData(contentsOfFile: path)!
        
        stub(uri("https://api.doordash.com/v1/store_search/?lat=37.42274&lng=-122.139956"), jsonData(data as Data))
        
        let promise = expectation(description: "Restaurant Search Request")
        URLSession.shared.dataTask(with: restaurantSearchUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                
                let result = try JSONDecoder().decode([Restaurant].self, from: data)
                if let firstRestaurant = result.first {
                    XCTAssertTrue(firstRestaurant.business!.name == "Noodle Talk")
                    XCTAssertTrue(firstRestaurant.description == "Chinese")
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
