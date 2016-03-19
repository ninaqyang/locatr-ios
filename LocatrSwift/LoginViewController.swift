//
//  ViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/2/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import ObjectMapper

class LoginViewController: UIViewController, UserServiceDelegate {
    
    let customColors: CustomColors = CustomColors.init()
    let userService: UserService = UserService.init()
    var user: [String: String] = [:]
    let facebookReadPermissions: [String] = ["public_profile", "email"]
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDescription: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet var signupView: UIView!
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var signupName: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userService.delegate = self
        
        self.appDetails()
        self.segmentedControl.customBorder()
        self.segmentedControl.textStyle(self.customColors.mediumGrey, selectedColor: self.customColors.darkPurple)
        
        self.loginViewCreate()
        self.signupViewCreate()
        self.signupView.hidden = true
    }
    
    // MARK: - Styling
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func appDetails() {
        self.appName.text = "LOCATR"
        self.appName.font = UIFont(name: "Fabrica", size: 24)
        self.appDescription.font = UIFont(name: "Calibri", size: 16)
    }
    
    // MARK: - Login/Signup Layout
    
    func signupViewCreate() {
        self.view.addSubview(self.signupView)
        
        // Autolayout
        self.signupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.signupView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 320).active = true
        NSLayoutConstraint(item: self.signupView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 267).active = true
        NSLayoutConstraint(item: self.signupView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: self.signupView, attribute: .CenterY, relatedBy: .Equal, toItem: self.segmentedControl, attribute: .CenterY, multiplier: 1, constant: 152).active = true
        
        // Textboxes
        self.signupEmail.customFont("Email", placeholderColor: self.customColors.unselectedTextGrey)
        self.signupName.customFont("Name", placeholderColor: self.customColors.unselectedTextGrey)
        self.signupPassword.customFont("Password", placeholderColor: self.customColors.unselectedTextGrey)
    }
    
    func loginViewCreate() {
        self.view.addSubview(self.loginView)
       
        // Autolayout
        self.loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.loginView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 320).active = true
        NSLayoutConstraint(item: self.loginView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 232).active = true
        NSLayoutConstraint(item: self.loginView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: self.loginView, attribute: .CenterY, relatedBy: .Equal, toItem: self.segmentedControl, attribute: .CenterY, multiplier: 1, constant: 130).active = true
        
        // Textboxes
        self.loginEmail.customFont("Name", placeholderColor: self.customColors.unselectedTextGrey)
        self.loginPassword.customFont("Password", placeholderColor: self.customColors.unselectedTextGrey)
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // Login
            UIView.animateWithDuration(0.3, animations: {
                self.signupView.alpha = 0
                self.loginView.alpha = 1
            })
        case 1: // Sign Up
            UIView.animateWithDuration(0.3, animations: {
                self.signupView.hidden = false
                self.signupView.alpha = 1
                self.loginView.alpha = 0
            })
        default:
            break; 
        }
    }
    
    // MARK: - Email Login/Signup

    @IBAction func emailSignup(sender: AnyObject) {
        // should also check if email is proper format
        guard let userEmail = self.signupEmail.text, userName = self.signupName.text, userPassword = self.signupPassword.text
            where !userEmail.isEmpty && !userName.isEmpty && !userPassword.isEmpty else {
                textfieldError()
                return
        }
        self.user = ["email": userEmail, "name": userName, "password": userPassword]
        print(self.user)
        self.userService.createUser(self.user)
    }
    
    @IBAction func emailLogin(sender: AnyObject) {
        // should also check if email is proper format
        guard let userEmail = self.loginEmail.text, userPassword = self.loginPassword.text
            where !userEmail.isEmpty && !userPassword.isEmpty else {
                textfieldError()
                return
        }
        self.user = ["email": userEmail, "password": userPassword]
        print(self.user)
//        self.userService.getUsers { (self.user) -> () in
//            //
//        }
    }
    
    func textfieldError() {
        print("One of the text fields is empty, not allowed")
        let alertView = UIAlertController(title: "No text fields can be empty", message: "Please fill out every field", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    // MARK: - Facebook Login/Signup
    
    @IBAction func fbSignup(sender: AnyObject) {
        FBSDKLoginManager().logInWithReadPermissions(self.facebookReadPermissions, fromViewController: self, handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
            if (error != nil) {
                // Process error
                self.removeFbData()
            } else if result.isCancelled {
                // User Cancellation
                self.removeFbData()
            } else {
                //Success
                // If you ask for multiple permissions at once, you should check if specific permissions missing
                var allPermsGranted = true
                
                //result.grantedPermissions returns an array of _NSCFString pointers
                let grantedPermissions = Array(result.grantedPermissions).map( {"\($0)"} )
                
                for permission in self.facebookReadPermissions {
                    if !grantedPermissions.contains(permission) {
                        allPermsGranted = false
                        break
                    }
                }
                if allPermsGranted {
                    let fbToken = result.token.tokenString
                    let fbUserID = result.token.userID
                    self.user = ["fbUserID": fbUserID, "fbTokenString": fbToken]
                    
                    self.userService.createUser(self.user)
                } else {
                    //Handle error
                }
            }
        })
    }
    
    func removeFbData() {
        //Remove FB Data
        let fbManager = FBSDKLoginManager()
        fbManager.logOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
    @IBAction func fbLogin(sender: AnyObject) {
        // before user service calls implemented, move to next view controller
        
        let tabBarController = TabBarController.init()
        self.presentViewController(tabBarController, animated: true, completion: nil)
    }
    
    // MARK: - API Callback
    
    func signupComplete() {
        // parameters get user back as response, store in user
        
        if defaults.boolForKey("Success") {
            defaults.setBool(true, forKey: "isUserLoggedIn")
//            let overviewVC = OverviewViewController(nibName: "OverviewViewController", bundle: nil)
//            let navController = UINavigationController(rootViewController: overviewVC)
//            self.presentViewController(tabBarController, animated: true, completion: nil)
        } else {
            print("Signup not successful")
        }
    }
    
    func fbSignupComplete() {
        if defaults.boolForKey("Success") {
            // parameters get user back as response, store in user

            if FBSDKAccessToken.currentAccessToken() != nil {
                defaults.setBool(true, forKey: "isUserLoggedIn")
                // User is already logged in, do work such as go to next view controller.
                //            //For debugging, when we want to ensure that facebook login always happens
                //            FBSDKLoginManager().logOut()
                //            //Otherwise do:
                //            return
            } else {
                print("User not logged in through fb")
            }
        } else {
            print("Signup not successful")
        }
    }
}

