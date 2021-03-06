//
//  AppDelegate.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/2/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    var loginVC: LoginViewController?
    
    let defaults = NSUserDefaults.standardUserDefaults()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Fb app launch code
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        //Optionally add to ensure your credentials are valid:
        FBSDKLoginManager.renewSystemCredentials { (result:ACAccountCredentialRenewResult, error:NSError!) -> Void in
            //
        }
        
        // Google maps
//        GMSServices.provideAPIKey("AIzaSyApwyXm8tT2ByHRT07wcW1EOCGF_BHo7Lg")
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        if defaults.boolForKey("isUserLoggedIn") {
            let tabBarController = TabBarController.init()
            self.window?.rootViewController = tabBarController
        } else {
            self.loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.window?.rootViewController = self.loginVC
        }
    
        self.window?.makeKeyAndVisible()

        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        // Facebook
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        
        // Yelp OAuth
//        if (url.host == "oauth-callback") {
//            OAuthSwift.handleOpenURL(url)
//        }
//        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        //App activation code
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

