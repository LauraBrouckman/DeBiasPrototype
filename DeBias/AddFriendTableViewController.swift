//
//  AddFriendTableViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/4/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import CoreData

extension AddFriendTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class AddFriendTableViewController: CoreDataTableViewController {
    

    var names = [String]()
    
    let searchController = UISearchController(searchResultsController: nil)

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        updateUI(searchText)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        updateUI("")
    }
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    
    
    private func updateUI(searchText: String) {
        if let context = managedObjectContext {
            let request = NSFetchRequest(entityName: "User")
            if searchText == "" {
                request.predicate = NSPredicate(format: "friend == 0", searchText)
            } else {
                request.predicate = NSPredicate(format: "friend == 0 and name contains[cd] %@", searchText)
            }
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
            cell.addFriendButton.tag = indexPath.row
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addFriend(sender: UIButton) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0)) as! AddFriendTableViewCell
        let name = cell.nameLabel!.text!
        let title = "Confirmation"
        let message =  "Are you sure you want to " + name + " as a friend?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        alert.modalInPopover = true
        
        alert.addAction(UIAlertAction(
            title: "Add Friend",
            style: .Default)
        { (action: UIAlertAction) ->  Void in
            self.managedObjectContext?.performBlock { [weak weakSelf = self] in
                User.changeFriendStatusOfUser(name, friend: true, inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
                let confirm = UIAlertController(title: "Sucess!", message: "Added " + name + " as a friend", preferredStyle: UIAlertControllerStyle.Alert)
                confirm.modalInPopover = true
                confirm.addAction(UIAlertAction(title: "Got it!", style: .Default) { (action: UIAlertAction) -> Void in
                    weakSelf?.updateUI("")
                    weakSelf?.searchController.active = false
                })
                weakSelf!.presentViewController(confirm, animated: true, completion: nil)
                do {
                    try (weakSelf?.managedObjectContext)!.save()
                } catch let error {
                    print(error)
                }
            }
            }
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .Default)
        { (action: UIAlertAction) ->  Void in
            }
        )
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
}
