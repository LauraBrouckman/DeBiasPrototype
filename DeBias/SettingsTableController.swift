//
//  SettingsTableController.swift
//  DeBias
//
//  Created by Leslie Kurt on 12/2/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class SettingsTableController: UITableViewController {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {

        if (indexPath.row == 0)
        {
            let cellIdentifier = "SettingsFieldCell1"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SettingsTableCell
            return cell
        }
        else if (indexPath.row == 1)
        {
            let cellIdentifier2 = "SettingsFieldCell2"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier2, forIndexPath: indexPath) as! SettingsTableCell
            return cell
        }
//        else if (indexPath.row == 2)
//        {
            let cellIdentifier2 = "SettingsFieldCell3"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier2, forIndexPath: indexPath) as! SettingsTableCell
            return cell
//        }
        
        

    }
    
//    let friendSegueIdentifier = "ShowFriendPieChart"
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if  segue.identifier == friendSegueIdentifier,
//            let destination = segue.destinationViewController as? FriendPieChartViewController,
//            let friendIndex = tableView.indexPathForSelectedRow?.row
//        {
//            destination.name = friends[friendIndex].name
//            destination.profilePic = friends[friendIndex].profilePic!
//            destination.articles = friends[friendIndex].articles
//        }
//    }
    
}

