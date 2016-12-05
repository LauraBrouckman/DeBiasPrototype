//
//  AddFriendTableViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/4/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import CoreData

class AddFriendTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //navTitle.title = "Friends"
        updateUI()
    }
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    

    
    private func updateUI() {
        if let context = managedObjectContext {
            let request = NSFetchRequest(entityName: "User")
            request.predicate = NSPredicate(format: "friend == 0")
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.rowHeight = 90
        let cell = tableView.dequeueReusableCellWithIdentifier("addFriendCell", forIndexPath: indexPath) as! AddFriendTableViewCell
        if let friend = fetchedResultsController?.objectAtIndexPath(indexPath) as? User {
            var name: String?
            var profileImageFile: String?
            
            friend.managedObjectContext?.performBlockAndWait {
                name = friend.name
                profileImageFile = friend.picture_filename
            }
            cell.nameLabel.text = name
            cell.profilePicture.image = UIImage(named: profileImageFile!)
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
//    let friendSegueIdentifier = "ShowFriendPieChart"
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if  segue.identifier == friendSegueIdentifier,
//            let destination = segue.destinationViewController as? FriendPieChartViewController,
//            cell = sender as? FriendTableViewCell
//        {
//            destination.articles = cell.articles
//            destination.name = cell.nameLabel.text!
//            destination.canSeeArticles = cell.canSeeArticles
//        }
//    }


}
