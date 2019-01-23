//
//  NativeNetworkClientSpec.swift
//  DoorDashAssignmentTests
//
//  Created by Renu Punjabi on 1/20/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Quick
import Nimble
import Mockingjay
@testable import DoorDashAssignment

class NativeNetworkClientSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("restaurantSearchRequest") {
            var restaurantArray: [Restaurant]?
            let urlString = "https://api.doordash.com/v1/store_search/?lat=37.42274&lng=-122.139956"
            
            beforeEach {
                restaurantArray = nil
            }
            
            context("success") {
                beforeEach{
                    let path = Bundle(for: type(of: self)).path(forResource: "DoorDashResponse", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri(urlString), jsonData(data as Data))
                    
                }
                
                it("returns [Restaurants]"){
                    NetworkProcessor.shared.getRestaurants(lat: "37.42274", lng: "-122.139956", completion: { (restaurants, _) in
                        let restaurant = restaurants?.first
                        expect(restaurantArray).toEventuallyNot(beNil(), timeout: 20)
                        expect(restaurant?.business!.name) == "Noodle Talk"
                        expect(restaurant?.description) == "Chinese"
                        expect(restaurant?.asapTime) == 39                    })
                   
                }
            }
            
            context("error") {
                let error = NSError(domain: "error during fetching restaurants list", code: 404, userInfo: nil)
                
                beforeEach {
                    self.stub(uri("https://api.doordash.com/v1/store_search/lat=37.42274&lng=-122.139956"), failure(error))
                }
                
                it("returns error") {
                    NetworkProcessor.shared.getRestaurants(lat: "37.42274", lng: "-122.139956", completion: { (_ , err) in
                        expect(err).toEventuallyNot(beNil())
                        expect(err?._domain) == error.domain
                        expect(err?._code) == error.code
                    })
                }
            }
        }
        
    }
}

