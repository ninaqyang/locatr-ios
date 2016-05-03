//
//  EventDetailViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/12/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    let customColors: CustomColors = CustomColors.init()

    override func awakeFromNib() {
        //change background stuff
    }
}

class EventDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let customColors: CustomColors = CustomColors.init()
    let userCellID = "userCell"
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var iconType: UIImageView!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventAddress1: UILabel!
    @IBOutlet weak var eventAddress2: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        // Nav bar style
        if let navController = self.navigationController {
            navController.navigationBar.customizeBar(.Black, title: "Event Details", barTint: self.customColors.lightPurple, allOtherTint: UIColor.whiteColor())
        }
        self.navBarItems()
        
        self.pageItems()
        self.tableViewSetup()
    }
    
    func navBarItems() {
        let profileItem = UIBarButtonItem.init(image: UIImage(imageLiteral: "profile"), style: .Plain, target: self, action: Selector("profilePage"))
        let shareItem = UIBarButtonItem.init(image: UIImage(imageLiteral: "share"), style: .Plain, target: self, action: Selector("socialShare"))
        let actionItems = [profileItem, shareItem]
        self.navigationItem.rightBarButtonItems = actionItems
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel.init(frame: CGRectZero)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = self.customColors.lightPurple
        titleLabel.numberOfLines = 0
        self.navigationItem.titleView = titleLabel
    }
    
    func profilePage() {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: profileVC)
        self.presentViewController(navController, animated: true, completion: nil)
    }

    func socialShare() {
        // text should say activity and time and people invited
        let textToShare = "I'm attending ACTIVITY at PLACE with PEOPLE."
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func pageItems() {
        self.eventTime.font = UIFont(name: "Calibri", size: 28)
        self.eventTime.textColor = self.customColors.darkGrey
        
        self.eventTitle.font = UIFont(name: "Calibri", size: 22)
        self.eventTitle.textColor = self.customColors.darkGrey
        
        self.eventAddress1.font = UIFont(name: "Calibri", size: 18)
        self.eventAddress1.textColor = self.customColors.mediumGrey
        
        self.eventAddress2.font = UIFont(name: "Calibri", size: 18)
        self.eventAddress2.textColor = self.customColors.mediumGrey
    }
    
    func tableViewSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "UserCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: userCellID)
    }
    
    // MARK: - Edit Event
    
    @IBAction func editEvent(sender: AnyObject) {
        
    }
    
    // MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(userCellID, forIndexPath: indexPath) as! UserCell

        //fill cell with info
        
        return cell
    }

    // MARK: - Table View Delegate

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.productsVC.title = self.dao.companyDAOList[indexPath.row].companyName
//        self.productsVC.products = self.dao.companyDAOList[indexPath.row].products
//        self.navigationController?.pushViewController(self.productsVC, animated: true)
//    }

}
