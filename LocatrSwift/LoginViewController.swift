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
    
    @IBOutlet var signupView: UIView!
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var signupPhone: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var signupName: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginName: UITextField!

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
        
        self.loginViewCreate()
        self.signupViewCreate()
        self.signupView.hidden = true
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
    
    // MARK: Login/Signup
    
    func signupViewCreate() {
        self.view.addSubview(self.signupView)
        
        // Autolayout
        self.signupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.signupView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 320).active = true
        NSLayoutConstraint(item: self.signupView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 267).active = true
        NSLayoutConstraint(item: self.signupView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: self.signupView, attribute: .CenterY, relatedBy: .Equal, toItem: self.segmentedControl, attribute: .CenterY, multiplier: 1, constant: 152).active = true
        
        // Textboxes
        self.signupPhone.customFont("Phone Number", placeholderColor: self.customColors.unselectedTextGrey)
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
        self.loginName.customFont("Name", placeholderColor: self.customColors.unselectedTextGrey)
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

