//
//  AddEventViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/17/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import UIKit

class InviteUserCell: UITableViewCell {
    let customColors: CustomColors = CustomColors.init()
    
    override func awakeFromNib() {
        //change background stuff
    }
}

class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITextFieldDelegate {
    let customColors: CustomColors = CustomColors.init()
    var locationService: LocationService = LocationService.sharedInstance
    let yelpService: YelpService = YelpService.init()
    let inviteUserCellID = "inviteUserCell"
    let locationCellID = "locationCell"

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var invitedLabel: UILabel!
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var inviteUserTableView: UITableView!
    @IBOutlet weak var inviteUserSearch: UISearchBar!
    @IBOutlet weak var locationSearch: UISearchBar!
    
    // MARK: - View
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        self.tabBarController?.tabBar.hidden = true
        
        self.pageItems()
        self.tableViewSetup()
        
        self.locationSearch.delegate = self
        self.inviteUserSearch.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        var title = "Add Event" // change depending on coming from which screen
        
        // Nav bar style
        if let navController = self.navigationController {
            navController.navigationBar.customizeBar(.Default, title: title, barTint: self.customColors.backgroundGrey, allOtherTint: self.customColors.lightPurple)
        }
        self.navBarItems()
        
        self.locationTableView.hidden = true
        self.inviteUserTableView.hidden = true
    }
    
    func navBarItems() {
        let saveItem = UIBarButtonItem.init(title: "Save", style: .Plain, target: self, action: Selector("saveEvent"))
        saveItem.setTitleTextAttributes([NSForegroundColorAttributeName:self.customColors.pink, NSFontAttributeName: UIFont(name: "Fabrica", size: 14)!], forState: .Normal)
        self.navigationItem.rightBarButtonItem = saveItem

        let cancelItem = UIBarButtonItem.init(title: "Cancel", style: .Plain, target: self, action: Selector("cancelEvent"))
        cancelItem.setTitleTextAttributes([NSForegroundColorAttributeName:self.customColors.lightPurple, NSFontAttributeName: UIFont(name: "Fabrica", size: 14)!], forState: .Normal)
        self.navigationItem.leftBarButtonItem = cancelItem
    }
    
    func saveEvent() {
        // send event data to database, then reload data on event view controller
    }
    
    func cancelEvent() {
        let alertController = UIAlertController(
            title: "Are you sure you want to cancel adding an event?",
            message: "No event information will be saved.",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Yes", style: .Default) { (UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                print("Going back to previous VC")
            })
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func pageItems() {
        let titlePadding = UIView(frame:CGRect(x:0, y:0, width:50, height:0))
        self.name.setUnderline(self.customColors.lightGrey)
        self.name.leftViewMode = UITextFieldViewMode.Always
        self.name.leftView = titlePadding

        let startPadding = UIView(frame:CGRect(x:0, y:0, width:43, height:0))
        self.start.setUnderline(self.customColors.lightGrey)
        self.start.leftViewMode = UITextFieldViewMode.Always
        self.start.leftView = startPadding
        
        let endPadding = UIView(frame:CGRect(x:0, y:0, width:35, height:0))
        self.end.setUnderline(self.customColors.lightGrey)
        self.end.leftViewMode = UITextFieldViewMode.Always
        self.end.leftView = endPadding
        
        self.locationLabel.setUnderline(self.customColors.lightGrey)
        self.locationLabel.font = UIFont(name: "Calibri", size: 17)
        self.invitedLabel.setUnderline(self.customColors.lightGrey)
        self.invitedLabel.font = UIFont(name: "Calibri", size: 17)
        
        self.locationSearch.customizeSearchBar(self.locationSearch)
        self.locationSearch.setUnderline(self.customColors.lightGrey)
        self.inviteUserSearch.customizeSearchBar(self.inviteUserSearch)
        self.inviteUserSearch.setUnderline(self.customColors.lightGrey)
        
        let addressText = self.locationSearch.valueForKey("searchField") as! UITextField
        addressText.font = UIFont(name: "Calibri", size: 17)
        addressText.textColor = self.customColors.darkGrey

        let inviteText = self.inviteUserSearch.valueForKey("searchField") as! UITextField
        inviteText.font = UIFont(name: "Calibri", size: 17)
        inviteText.textColor = self.customColors.darkGrey
    }
    
    func tableViewSetup() {
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        self.locationTableView.tag = 1
        self.inviteUserTableView.delegate = self
        self.inviteUserTableView.dataSource = self
        self.inviteUserTableView.tag = 2
        
        self.locationTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: locationCellID)
        self.inviteUserTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: locationCellID)

    }
    
    // MARK: - Search Controller
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        shouldShowSearchResults = true
//        tblSearchResults.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        shouldShowSearchResults = false
//        tblSearchResults.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let latitude = self.locationService.locationManager.location?.coordinate.latitude, longitude = self.locationService.locationManager.location?.coordinate.longitude else {
            // uialert that location is off
            return
        }
        print("Latitude: \(latitude), Longitude: \(longitude)")
        
        guard let text = self.locationSearch.text else {
            print("Need to enter search term")
            return
        }
        print(text, latitude, longitude)
        self.yelpService.yelpOAuth(text, latitude: latitude, longitude: longitude)
        
    }
    
    // MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let inviteCell = tableView.dequeueReusableCellWithIdentifier(inviteUserCellID, forIndexPath: indexPath) as! InviteUserCell
        
        var locationCell = tableView.dequeueReusableCellWithIdentifier(locationCellID, forIndexPath: indexPath) as? UITableViewCell
        if locationCell == nil {
            locationCell = UITableViewCell(style: .Subtitle, reuseIdentifier: locationCellID)
        }
        
        if tableView.tag == 1 {
            return locationCell!
        } else {
            return locationCell!
        }
        
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // fill uitextfield with data
        
//        self.productsVC.title = self.dao.companyDAOList[indexPath.row].companyName
//        self.productsVC.products = self.dao.companyDAOList[indexPath.row].products
//        self.navigationController?.pushViewController(self.productsVC, animated: true)
    }
    
    // MARK: - UIPicker View
    
    @IBAction func textfieldWhen(sender: UITextField) {
        let pickerView:UIDatePicker = UIDatePicker()
        pickerView.datePickerMode = .DateAndTime
        sender.inputView = pickerView
        pickerView.addTarget(self, action: Selector("pickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    func pickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        if self.start.isFirstResponder() {
            self.start.text = dateFormatter.stringFromDate(sender.date)
        }
        
        if self.end.isFirstResponder() {
            self.end.text = dateFormatter.stringFromDate(sender.date)
        }
    }
    
}