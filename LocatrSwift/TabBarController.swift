//
//  RootViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/9/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let customColors: CustomColors = CustomColors.init()
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let overviewVC = OverviewViewController(nibName: "OverviewViewController", bundle: nil)
        let eventsVC = EventsViewController(nibName: "EventsViewController", bundle: nil)
        let overviewNav = UINavigationController(rootViewController: overviewVC)
        let eventsNav = UINavigationController(rootViewController: eventsVC)
        
        self.tabBar.barTintColor = UIColor.whiteColor()
        let item1 = UITabBarItem.init(title: "Overview", image: UIImage(imageLiteral: "tabbar-overview"), tag: 0)
        let item2 = UITabBarItem.init(title: "Events", image: UIImage(imageLiteral: "tabbar-events"), tag: 1)
        overviewNav.tabBarItem = item1
        eventsNav.tabBarItem = item2
        overviewNav.tabBarItem.customizeTabBarItems(self.customColors.mediumGrey, selectedColor: self.customColors.darkPurple, normalIcon: "tabbar-overview", selectedIcon: "tabbar-overview-selected")
        eventsNav.tabBarItem.customizeTabBarItems(self.customColors.mediumGrey, selectedColor: self.customColors.darkPurple, normalIcon: "tabbar-events", selectedIcon: "tabbar-events-selected")
        self.viewControllers = [overviewNav, eventsNav]
    }
    
    // MARK: - Delegate
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }
    
}
