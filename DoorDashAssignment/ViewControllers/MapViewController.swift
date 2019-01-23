//
//  MapViewController.swift
//  DoorDashAssignment
//
//  Created by Renu Punjabi on 1/19/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

//This viewController class manages taking in the user selection for loaction on the map view

import UIKit
import MapKit
import CoreLocation

/// This class shows user current location on map view. It also lets user pick another location by enabling tap gesture on map view. The selected location is displayed in the text view. In a nutshell, this class handles user interaction with map view.
class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let pin = MKPointAnnotation()
    var addressOfDesiredLocation = ""
    let locationManager = CLLocationManager()
    var myLocation: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes =  textAttributes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackBarButton()
        setUpLocationManager()
        addTapGestureToTheMap()
    }
    
    //MARK: Private methods
    
    /// Customize BackBarItemButton
    private func customizeBackBarButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav-address")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav-address")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    /// Adds tap gesture to Map
    private func addTapGestureToTheMap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
    }
    
    /// Handle tap on the mapView. User taps on map view to select a new location
    ///
    /// - Parameter tapGesture: tap Gesture
    @objc private func handleTap(_ tapGesture: UITapGestureRecognizer) {
        let location = tapGesture.location(in: mapView)
        let newCoordinates = mapView.convert(location, toCoordinateFrom: mapView)
        let newLocation = CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude)
        if (myLocation?.latitude != newCoordinates.latitude || myLocation?.longitude != newCoordinates.longitude) {
            myLocation?.latitude = newCoordinates.latitude
            myLocation?.longitude = newCoordinates.longitude
        }
        populateAddressTextViewPerNewLocation(newLocation)
        centerMap(coordinates: newCoordinates, spanX: mapView.region.span.latitudeDelta, spanY: mapView.region.span.longitudeDelta)
    }
    
    /// Populate Address Text View with selected location
    ///
    /// - Parameter newLocation: new selected location
    private func populateAddressTextViewPerNewLocation(_ newLocation: CLLocation){
        MapViewModel.getAddress(newLocation, completionHandler: { (address) in
            self.addressTextView.textColor = UIColor.black
            
            if (address != self.addressOfDesiredLocation) {
                self.addressOfDesiredLocation = address
                self.addressTextView.text = address
            }
            self.locationManager.stopUpdatingLocation()
        })
    }
    
    /// Setting up location manager to get user's current location
    private func setUpLocationManager() {
        //Ask for permission, when in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coordinates = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coordinates, animated: true)
        }
    }
    
    /// Centers the map using coordinates
    ///
    /// - Parameters:
    ///   - coordinates: location coordinates
    ///   - spanX: amount of span for how much to zoom in x-coordinate
    ///   - spanY: amount of span for how much to zoom in y-coordinate
    fileprivate func centerMap(coordinates: CLLocationCoordinate2D, spanX: Double?, spanY: Double?) {
        mapView.removeAnnotation(pin)
        myLocation = coordinates
        
        let deltaX = spanX ?? 0.05
        let deltaY = spanY ?? 0.05
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: deltaX, longitudeDelta: deltaY))
        mapView.setRegion(region, animated: true)
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToRestaurantsList" {
            guard let vc = segue.destination as? UITabBarController, let restaurantListVC = vc.viewControllers?.first as? RestaurantListViewController else {
                assertionFailure("Pleace check the navigation to RestaurantVC from MapVC")
                return
            }
            restaurantListVC.latitude = myLocation?.latitude ?? 0.0
            restaurantListVC.longitude = myLocation?.longitude ?? 0.0
        }
    }
}

//MARK: MKMapViewDelegate and CLLocationManagerDelegate methods
extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.first else {
            return
        }
        populateAddressTextViewPerNewLocation(newLocation)
        centerMap(coordinates: newLocation.coordinate, spanX: nil, spanY: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        #if DEBUG
        print("error:: \(error)")
        #endif
    }
    
    private func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == .began || recognizer.state == .ended ) {
                    return true
                }
            }
        }
        return false
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let _ = mapViewRegionDidChangeFromUserInteraction()
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    }
}



