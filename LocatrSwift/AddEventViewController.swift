//
//  AddEventViewController.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/17/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import UIKit

class AddEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    let customColors: CustomColors = CustomColors.init()
    let cellID = "userCell"

    @IBOutlet weak var eventTime: UITextField!
    @IBOutlet weak var eventDate: UITextField!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var invitedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var inviteTableView: UITableView!
    @IBOutlet weak var eventInviteSearch: UISearchBar!
    @IBOutlet weak var eventAddressSearch: UISearchBar!
    
    var addressSearch: UISearchController!
    
    // MARK: - View
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        self.tabBarController?.tabBar.hidden = true
        
        self.pageItems()
//        self.configureSearchController()

//        self.addressTableView.tag = 1
//        self.inviteTableView.tag = 2
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        var title = "Add Event" // change depending on coming from which screen
        
        // Nav bar style
        if let navController = self.navigationController {
            navController.navigationBar.customizeBar(.Default, title: title, barTint: self.customColors.backgroundGrey, allOtherTint: self.customColors.lightPurple)
        }
        self.navBarItems()
        
//        self.addressTableView.hidden = true
//        self.inviteTableView.hidden = true
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
        self.eventTitle.setUnderline(self.customColors.lightGrey)
        self.eventTitle.leftViewMode = UITextFieldViewMode.Always
        self.eventTitle.leftView = titlePadding

        let datePadding = UIView(frame:CGRect(x:0, y:0, width:40, height:0))
        self.eventDate.setUnderline(self.customColors.lightGrey)
        self.eventDate.leftViewMode = UITextFieldViewMode.Always
        self.eventDate.leftView = datePadding
        
        let timePadding = UIView(frame:CGRect(x:0, y:0, width:30, height:0))
        self.eventTime.setUnderline(self.customColors.lightGrey)
        self.eventTime.leftViewMode = UITextFieldViewMode.Always
        self.eventTime.leftView = timePadding
        
        self.addressLabel.setUnderline(self.customColors.lightGrey)
        self.addressLabel.font = UIFont(name: "Calibri", size: 17)
        self.invitedLabel.setUnderline(self.customColors.lightGrey)
        self.invitedLabel.font = UIFont(name: "Calibri", size: 17)
        
        self.eventAddressSearch.customizeSearchBar(self.eventAddressSearch)
        self.eventAddressSearch.setUnderline(self.customColors.lightGrey)
        self.eventInviteSearch.customizeSearchBar(self.eventInviteSearch)
        self.eventInviteSearch.setUnderline(self.customColors.lightGrey)
    }
    
    // MARK: - Search Controller
    
//    func configureSearchController() {
//        // Initialize and perform a minimum configuration to the search controller.
//        self.addressSearch = UISearchController(searchResultsController: nil)
//        self.addressSearch.searchResultsUpdater = self
//        self.addressSearch.dimsBackgroundDuringPresentation = false
//        self.addressSearch.searchBar.placeholder = "Search here..."
//        self.addressSearch.searchBar.delegate = self
//        self.addressSearch.searchBar.sizeToFit()
//        
//        // Place the search bar view to the tableview headerview.
////        self.addressTableView.tableHeaderView = self.addressSearch.searchBar
//    }
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! UserCell
        
        if tableView.tag == 1 {
            
        }
        
        if tableView.tag == 2 {
            
        }
        
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