//
//  MapViewModel.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/20/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import MapKit

final class MapViewModel {
    
    /// Get Address for a given Location
    ///
    /// - Parameters:
    ///   - location: CLLocation parameter
    ///   - completionHandler: Contains address string
    static func getAddress(_ location: CLLocation, completionHandler: @escaping ((String) -> Void)) {
        var address = ""
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                #if DEBUG
                print("error = \(String(describing: error))")
                #endif
            } else {
                guard let placemark = placemarks?.first else {
                    return
                }
                address = ""
                
                if let subStreet = placemark.subThoroughfare {
                    address = address + subStreet + " "
                }
                if let streetName = placemark.thoroughfare {
                    address = address + streetName + ", "
                }
                if let city = placemark.locality {
                    address = address + city + ", "
                }
                if let state = placemark.administrativeArea {
                    address = address + state + ", "
                }
                if let county = placemark.subAdministrativeArea {
                    address = address + county + ", "
                }
                if let zip = placemark.postalCode {
                    address = address + zip + ", "
                }
                if let country = placemark.country {
                    address = address + country + ", "
                }
            }
            completionHandler(address)
        }
    }
    
}
