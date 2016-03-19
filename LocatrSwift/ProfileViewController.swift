//
//  ProfileViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/14/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum LocationSwitch {
    case FirstLoad
    case LaterLoads
}

class ProfileViewController: UIViewController, LocationManagerDelegate {
    
    let customColors: CustomColors = CustomColors.init()
    var locationManager: LocationManager = LocationManager.sharedInstance
    let defaults = NSUserDefaults.standardUserDefaults()
    var locationSwtichLoad: LocationSwitch?

    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var profileName: UILabel!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        
        // Nav bar style
        if let navController = self.navigationController {
            navController.navigationBar.customizeBar(.Default, title: "Profile", barTint: self.customColors.backgroundGrey, allOtherTint: self.customColors.lightPurple)
        }
        self.navBarItems()
        self.pageItems()
        
        self.locationManager.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if defaults.boolForKey("locationOn") {
            self.locationSwitch.setOn(true, animated: false)
        } else {
            self.locationSwitch.setOn(false, animated: false)
        }

    }
    
    // MARK: - Styling
    
    func navBarItems() {
        let doneItem = UIBarButtonItem.init(title: "Done", style: .Plain, target: self, action: Selector("done"))
        if let font = UIFont(name: "Fabrica", size: 14) {
            doneItem.setTitleTextAttributes([NSForegroundColorAttributeName:self.customColors.lightPurple, NSFontAttributeName: font], forState: .Normal)
        }
        self.navigationItem.rightBarButtonItem = doneItem
    }
    
    func done() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Exit profile page")
        }
    }
    
    func pageItems() {
        self.profileName.font = UIFont(name: "Calibri", size: 22)
        self.eventDescription.font = UIFont(name: "Calibri", size: 14)
        self.currentLocation.font = UIFont(name: "Calibri", size: 16)

        let circleView = UIImageView.init(frame: CGRectMake(0, 0, 110, 110))
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
        circleView.backgroundColor = self.customColors.darkPurple
        
        let imageView = UIImageView.init(frame: CGRectMake(3, 3, 104, 104))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.backgroundColor = UIColor.whiteColor()
        
        circleView.addSubview(imageView)
        self.profileImage.addSubview(circleView)
    }
    
    // MARK: - Location Switch
    
    @IBAction func locationSwitch(sender: AnyObject) {
        // figure out how to not show other users who haven't enabled locations on map
        if self.locationSwitch.on {
            self.currentLocation.fadeTransition(0.4)
            self.currentLocation.text = "Current Location ON"
            defaults.setBool(self.locationSwitch.on, forKey: "locationOn")
            self.locationManager.locationOn()
        } else {
            self.currentLocation.fadeTransition(0.4)
            self.currentLocation.text = "Current Location OFF"
            defaults.setBool(false, forKey: "locationOn")
            self.locationManager.locationOff()
        }
    }

}