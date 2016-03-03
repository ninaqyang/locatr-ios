//
//  ViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/2/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        findFontName()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func findFontName() {
        for family: String in UIFont.familyNames() {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family) {
                print("== \(names)")
            }
        }
    }


}

