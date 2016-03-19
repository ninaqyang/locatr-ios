//
//  EventsViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/9/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    let customColors: CustomColors = CustomColors.init()
    
    @IBOutlet weak var iconType: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 1.0
        self.layer.shadowOffset = CGSizeMake(0, 2)
        
        self.title.font = UIFont(name: "Calibri", size: 18)
        self.title.textColor = self.customColors.darkGrey
        
        self.location.font = UIFont(name: "Calibri", size: 15)
        self.location.textColor = self.customColors.mediumGrey
        
        self.time.font = UIFont(name: "Calibri", size: 15)
        self.time.textColor = self.customColors.darkGrey
    }
}

class EventsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let customColors: CustomColors = CustomColors.init()
    let cellID = "eventCell"
//    let eventDetailsVC: EventDetailsViewController?
 
    // Filler placeholders
    let event1 = Event.init(iconType: "foodIcon", title: "Sharon's Birthday", location: "Sweet and Vicious", time: "7:00PM")
    let event2 = Event.init(iconType: "foodIcon", title: "Nina's Birthday", location: "McDonalds", time: "8:00PM")
    let event3 = Event.init(iconType: "foodIcon", title: "Chris's Birthday", location: "Rise", time: "7:00PM")
    var eventList: [Event] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        
        // Nav bar style
        if let navController = self.navigationController {
            navController.navigationBar.customizeBar(.Black, title: "Events", barTint: self.customColors.lightPurple, allOtherTint: UIColor.whiteColor())
        }
        self.navBarItems()

        self.eventList = [event1, event2, event3]
        
        self.collectionViewSetup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Styling
    
    func navBarItems() {
        let profileItem = UIBarButtonItem.init(image: UIImage(imageLiteral: "profile"), style: .Plain, target: self, action: Selector("profilePage"))
        self.navigationItem.rightBarButtonItem = profileItem
    }
    
    func profilePage() {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: profileVC)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func collectionViewSetup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = self.customColors.backgroundGrey
        
        let nib = UINib(nibName: "EventCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: cellID)
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 30, 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.scrollDirection = .Vertical
        self.collectionView.collectionViewLayout = flowLayout
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    // MARK: - CollectionView Data Source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! EventCell
        
        let event = self.eventList[indexPath.row] as Event
        if let iconType = event.iconType {
            cell.iconType.image = UIImage(imageLiteral: iconType)
        }
        cell.title.text = event.title
        cell.location.text = event.address1
        cell.time.text = event.time
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let eventDetailVC = EventDetailsViewController(nibName: "EventDetailsViewController", bundle: nil)
//        self.productsVC.title = self.dao.companyDAOList[indexPath.row].companyName
//        self.productsVC.products = self.dao.companyDAOList[indexPath.row].products
        self.navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    // MARK: - Add Event
    
    @IBAction func addEvent(sender: AnyObject) {
        let addEventVC = AddEventViewController(nibName: "AddEventViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: addEventVC)
        self.presentViewController(navController, animated: true, completion: nil)
    }

}
