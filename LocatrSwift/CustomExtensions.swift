//
//  CustomNavBar.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/8/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

// MARK: - Login / Signup Screen

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

// MARK: - Tab Bar

extension UITabBar {
    func tabBar(item: UITabBarItem) {
        var items: [UITabBarItem] = []
        items.append(item)
        setItems(items, animated: true)        
    }
}

extension UITabBarItem {
    func customizeTabBarItems(normalColor: UIColor, selectedColor: UIColor, normalIcon: String, selectedIcon: String) {
        if let font = UIFont(name: "Fabrica", size: 10) {
            setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: normalColor], forState: .Normal)
            setTitleTextAttributes([NSFontAttributeName: font, NSForegroundColorAttributeName: selectedColor], forState: .Selected)
        }
        
        image = UIImage(imageLiteral: normalIcon).imageWithRenderingMode(.AlwaysOriginal)
        selectedImage = UIImage(imageLiteral: selectedIcon).imageWithRenderingMode(.AlwaysOriginal)
        
    }
}

// MARK: - Nav Bar

extension UINavigationBar {
    func customizeBar(statusBarStyle:UIBarStyle, title: String, barTint: UIColor, allOtherTint: UIColor) {
        barStyle = statusBarStyle
        
        if let item = topItem {
            item.title = title
        }
        
        barTintColor = barTint
        tintColor = allOtherTint
        
        if let titleFont = UIFont(name: "Fabrica", size: 17) {
            titleTextAttributes = [NSForegroundColorAttributeName:allOtherTint, NSFontAttributeName: titleFont]
        }
        
        //add barbuttonitems (profile that shows up on each page for now)
        
        // back button image
//        let insets = UIEdgeInsetsMake(0, -600, 0, 0)
        let backButton = UIImage(imageLiteral: "back-button")
        backIndicatorImage = backButton
        backIndicatorTransitionMaskImage = backButton
    }
    
//    func navBarItems(extraItem: UINavigationItem) {
//        let profileItem = UIBarButtonItem.init(image: UIImage(imageLiteral: "profile"), style: .Plain, target: self, action: Selector("profilePage"))
//        var items = [profileItem, extraItem]
////        navigationItem.rightBarButtonItem = profileItem
//    }
//    
//    func profilePage() {
//        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
//        self.presentViewController(profileVC, animated: true, completion: nil)
//    }

}

// MARK: - Fade Transitions

extension UIView {
    func fadeTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.addAnimation(animation, forKey: kCATransitionFade)
    }
}

// MARK: - Text Label

extension UILabel {
    func setUnderline(color: UIColor) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, self.frame.size.height - 9, self.frame.size.width, 1.0);
        bottomBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(bottomBorder)
    }
}


// MARK: - Text Field

extension UITextField {
    func setUnderline(color: UIColor) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width, 1.0);
        bottomBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(bottomBorder)
    }
}

// MARK: - Search Bar

extension UISearchBar {
    func customizeSearchBar(bar: UISearchBar) {
//        barTintColor = UIColor.whiteColor()
        
        let image = self.getImageWithColor(UIColor.whiteColor(), size: CGSizeMake(5, 5))
        setImage(image, forSearchBarIcon: .Search, state: .Normal)
        
        backgroundImage = self.getImageWithColor(UIColor.whiteColor(), size: CGSizeMake(bar.frame.width, bar.frame.height))

    }
    
    private func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setUnderline(color: UIColor) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, self.frame.size.height - 6, self.frame.size.width, 1.0);
        bottomBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(bottomBorder)
    }
}
