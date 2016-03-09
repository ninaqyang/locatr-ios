//
//  CustomNavBar.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/8/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

class CustomNavBar: NSObject {
    
}

extension UINavigationBar {
    func customizeColor(barTint: UIColor, allOtherTint: UIColor, barItem: UINavigationItem) {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = barTint
        navigationBarAppearace.tintColor = allOtherTint
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:allOtherTint]
    }
    
    func customizeText() {
        let titleFont = UIFont(name: "Fabrica", size: 15)
    }
}