//
//  FriendTableViewController.swift
//  DeBias
//
//  Created by Leslie Kurt on 11/21/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import CoreData

class FriendTableViewController: CoreDataTableViewController {
    var friends = [Friend]()
    var sortByNumArticles = true
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var numArticlesButton: UIButton!
    @IBOutlet weak var diversityButton: UIButton!
    
    @IBAction func sortByDiversity(sender: UIButton) {
        print("diversity")
        updateUI("diversity")
        sortByNumArticles = false
        self.dropdownView.hidden = true
        self.sortTextbox.hidden = false
        self.sortTextbox.text = "Diversity"
    }
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        updateUI("numArticles")
        sortByNumArticles = true
        self.dropdownView.hidden = true
        self.sortTextbox.hidden = false
        self.sortTextbox.text = "Number of Articles"
    }
    
    @IBAction func closeMenu(sender: UITapGestureRecognizer) {
        self.dropdownView.hidden = true
        self.sortTextbox.hidden = false
    }
    
    
    @IBOutlet weak var sortTextbox: UITextField!

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.sortTextbox {
            self.dropdownView.hidden = false
            self.sortTextbox.hidden = true
            if sortByNumArticles {
                self.numArticlesButton.backgroundColor = UIColor(red: 28.0/255, green: 190/255, blue: 124/255, alpha: 0.15)
                self.diversityButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            } else {
                self.diversityButton.backgroundColor = UIColor(red: 28.0/255, green: 190/255, blue: 124/255, alpha: 0.15)
                self.numArticlesButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            }
            self.tableView.bringSubviewToFront(self.dropdownView)
            self.dropdownView.layer.zPosition+=10;
            textField.endEditing(true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        self.navigationController?.navigationBar.layer.shadowRadius = 4;
        self.navigationController?.navigationBar.layer.shadowOpacity = 1;
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 240.0/255, green: 240/255, blue: 240/255, alpha: 1.0)
        self.tabBarController?.tabBar.tintColor = UIColor(red: 28.0/255, green: 190/255, blue: 124/255, alpha: 1.0)
        
        
       // self.sortDropDown.hidden = true
        self.sortTextbox.text = "Number of Articles"
        updateUI("numArticles")
        sortByNumArticles = true
        self.dropdownView.hidden = true
        self.dropdownView.layer.borderWidth = 1
        self.dropdownView.layer.borderColor = UIColor(red:0.7, green:0.7, blue:0.7, alpha: 1.0).CGColor
        self.dropdownView.layer.cornerRadius = 6.0
        self.dropdownView.clipsToBounds = true

    }
    
    private func updateUI(sortKey: String) {
        if let context = managedObjectContext {
            let request = NSFetchRequest(entityName: "User")
            request.predicate = NSPredicate(format: "friend == 1")
            request.sortDescriptors = [NSSortDescriptor(key: sortKey, ascending: false)]
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
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell", forIndexPath: indexPath) as! FriendTableViewCell
        if let friend = fetchedResultsController?.objectAtIndexPath(indexPath) as? User {
            var name: String?
            var profileImageFile: String?
            var articles = [Article]()
            var canSeeArticles: Bool?
            
            friend.managedObjectContext?.performBlockAndWait {
                name = friend.name
                profileImageFile = friend.picture_filename
                articles = friend.articles!.allObjects as! [Article]
                canSeeArticles = (friend.canSeeArticles == 1)
            }
            cell.nameLabel.text = name
            cell.profilePicture.image = UIImage(named: profileImageFile!)
            cell.rankingLabel.text = String(indexPath.row + 1)
            cell.articles = articles
            cell.canSeeArticles = canSeeArticles!
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    
    let friendSegueIdentifier = "ShowFriendPieChart"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if  segue.identifier == friendSegueIdentifier,
            let destination = segue.destinationViewController as? FriendPieChartViewController,
            cell = sender as? FriendTableViewCell
        {
            destination.articles = cell.articles!
            destination.name = cell.nameLabel.text!
            destination.canSeeArticles = cell.canSeeArticles
           
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
}
