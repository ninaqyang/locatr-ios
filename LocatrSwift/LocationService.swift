//
//  LocationManager.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/15/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    // required 
    
    //optional
    func locationDenied()
}

extension LocationServiceDelegate {
    func locationDenied() {
    }
}

class LocationService: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationService()
    
    weak var delegate: LocationServiceDelegate?
    var locationManager: CLLocationManager = CLLocationManager.init()
//    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
    // MARK: - Location Manager Delgate
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Stop updating locations")
        self.locationManager.stopUpdatingLocation()
        if error == true {
            print("Error: \(error)")
            // send alert vc message back to vc
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = self.locationManager.location {
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            print("Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            break
        case .NotDetermined:
            self.locationManager.requestAlwaysAuthorization()
        case .Restricted, .Denied:
            if let delegate = self.delegate {
                dispatch_async(dispatch_get_main_queue()) {
                    delegate.locationDenied()
                }
            } else {
                print("Delegate nil")
            }
        }
        
        if CLLocationManager.locationServicesEnabled() {
            print("Start updating locations")
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Location On / Off
    
    func locationOn() {
        print("Start updating location")
        self.locationManager.startUpdatingLocation()
    }
    
    func locationOff() {
        print("Stop updating location")
        self.locationManager.stopUpdatingLocation()
    }
    
}