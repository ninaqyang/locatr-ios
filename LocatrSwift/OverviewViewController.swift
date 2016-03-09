//
//  OverviewViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/5/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    let customColors: CustomColors = CustomColors.init()

    // MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Styling
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}