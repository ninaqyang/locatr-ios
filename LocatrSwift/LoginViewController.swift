//
//  ViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/2/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

// MARK: - Classes

class LoginViewController: UIViewController {
    
    var customColors: CustomColors! = CustomColors.init()
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDescription: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var phoneTextbox: UITextField!
    @IBOutlet weak var nameTextbox: UITextField!
    @IBOutlet weak var passwordTextbox: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var facebookSignupButton: UIButton!
    @IBOutlet var signupView: UIView!
    @IBOutlet var loginView: UIView!

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDetails()
        self.segmentedControl.customBorder()
        self.segmentedControl.textStyle(self.customColors.mediumGrey, selectedColor: self.customColors.darkPurple)
        
//        if let customColors = self.customColors {
//            self.segmentedControl.textStyle(customColors.mediumGrey, selectedColor: customColors.darkPurple)
//        } else {
//            print("Custom colors aren't set")
//        }
        
        self.textBoxes()
        self.signupViewCreate()
        self.loginViewCreate()
    }
    
    // MARK: Styling
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func appDetails() {
        self.appName.text = "LOCATR"
        self.appName.font = UIFont(name: "Fabrica", size: 24)
        self.appDescription.font = UIFont(name: "Calibri", size: 16)
    }
    
    func textBoxes() {
        self.phoneTextbox.customFont("Phone Number", placeholderColor: self.customColors.unselectedTextGrey)
        self.nameTextbox.customFont("Name", placeholderColor: self.customColors.unselectedTextGrey)
        self.passwordTextbox.customFont("Password", placeholderColor: self.customColors.unselectedTextGrey)

    }
    
    // MARK: Login/Signup
    
    func signupViewCreate() {
        self.view.addSubview(self.signupView)
        //create constraints
    }
    
    func loginViewCreate() {
        self.view.addSubview(self.loginView)
        //create constraints
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // Login
            UIView.animateWithDuration(0.5, animations: {
                self.signupView.alpha = 0
                self.loginView.alpha = 1
            })
        case 1: // Sign Up
            UIView.animateWithDuration(0.5, animations: {
                self.signupView.alpha = 1
                self.loginView.alpha = 0
            })
        default:
            break; 
        }
    }

}

// MARK: - Extensions

extension UISegmentedControl {
    func customBorder() {
        setBackgroundImage(UIImage(imageLiteral: "segmented-control"), forState: .Normal, barMetrics: .Default)
        setBackgroundImage(UIImage(imageLiteral: "segmented-control-selected"), forState: .Selected, barMetrics: .Default)
        setContentPositionAdjustment(UIOffset(horizontal: 0, vertical: -4), forSegmentType: UISegmentedControlSegment.Any, barMetrics: .Default)
        setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func textStyle(normalColor: UIColor, selectedColor:UIColor) {
        let font = UIFont(name: "Calibri", size: 18)
        if let font = font {
            setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: normalColor], forState: .Normal)
            setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: selectedColor], forState: .Selected)
        }
    }
}

extension UITextField {
    func customFont(placeholderString: String, placeholderColor: UIColor) {
        font = UIFont(name: "Calibri", size: 14)
        attributedPlaceholder = NSAttributedString(string: placeholderString, attributes:[NSForegroundColorAttributeName : placeholderColor])
    }
}

