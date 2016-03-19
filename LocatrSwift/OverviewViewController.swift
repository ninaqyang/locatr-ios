//
//  OverviewViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/5/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return self.coordinate
    }
}

class OverviewViewController: UIViewController, MKMapViewDelegate, LocationManagerDelegate {
    
    let customColors: CustomColors = CustomColors.init()
    var locationManager: LocationManager = LocationManager.sharedInstance
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController!.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        // Nav bar style
        if let navController = self.navigationController {
            navController.navigationBar.customizeBar(.Black, title: "Overview", barTint: self.customColors.lightPurple, allOtherTint: UIColor.whiteColor())
        }
        self.navBarItems()

        self.locationManager.delegate = self
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .Follow
        self.mapView.zoomEnabled = true
        
        self.mapViewSetup()
    }
    
    // MARK: - Styling
    
    func navBarItems() {
        let locationItem = MKUserTrackingBarButtonItem.init(mapView: self.mapView)
        self.navigationItem.leftBarButtonItem = locationItem
        
        let profileItem = UIBarButtonItem.init(image: UIImage(imageLiteral: "profile"), style: .Plain, target: self, action: Selector("profilePage"))
        self.navigationItem.rightBarButtonItem = profileItem
    }
    
    func profilePage() {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: profileVC)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func mapViewSetup() {
        let location = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(location, 500, 500)
        let adjustedRegion = self.mapView.regionThatFits(viewRegion)
        self.mapView.setRegion(adjustedRegion, animated: true)
    }
    
    // MARK: - Location Manager CallBack
    
    func locationDenied() {
        let alertController = UIAlertController(
            title: "Background location access disabled.",
            message: "In order to be notified about your events and your friends' locations, please enable your location services.",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
            if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        alertController.addAction(openAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Add Event
    
    @IBAction func addEvent(sender: AnyObject) {
        let addEventVC = AddEventViewController(nibName: "AddEventViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: addEventVC)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    // MARK: - MapView Delgate

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        //zoom
//        var mapRegion = MKCoordinateRegion.init()
//        mapRegion.center = self.mapView.userLocation.coordinate
        
        var location = CLLocationCoordinate2D()
        location.latitude = userLocation.coordinate.latitude
        location.longitude = userLocation.coordinate.longitude
        print("Latitude: \(location.latitude), Longitude: \(location.longitude)")

    }
    
    // MARK: - MKAnnotation
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // This is false if its a user pin
        if(annotation.isKindOfClass(CustomAnnotation) == false) {
            let userPin = "userLocation"
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(userPin) {
                return dequeuedView
            } else {
                let mkAnnotationView:MKAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: userPin)
                mkAnnotationView.image = UIImage(imageLiteral: "user-location")
                return mkAnnotationView
            }
        }
        
        let annotation = annotation as? CustomAnnotation
        if (annotation == nil) {
            return nil
        }
        
        let endPointsIdentifier = "endPoint"
        if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(endPointsIdentifier) {
            dequeuedView.image = nil
            return dequeuedView
        } else {
            let mkAnnotationView:MKAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: endPointsIdentifier)
            mkAnnotationView.image = nil
            
            let gesture = UITapGestureRecognizer(target: self, action: "routeTouched:")
            mkAnnotationView.addGestureRecognizer(gesture)
            
            return mkAnnotationView
        }
    
    }

}