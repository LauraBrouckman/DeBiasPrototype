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
    
//    @IBAction func switchSort(sender: UISwitch) {
//            if (sortByNumArticles)
//            {
//                updateUI("diversity")
//                sortByNumArticles = false
//            }else
//            {
//                updateUI("numArticles")
//                sortByNumArticles = true
//            }
//    }
    
    
    @IBOutlet weak var sortTextbox: UITextField!
    @IBOutlet weak var sortDropDown: UIPickerView!
    var list = ["Number Articles","Diversity"]

    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return list.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        self.view.endEditing(true)
        return list[row]
        
        
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.sortTextbox.text = self.list[row]
        self.sortDropDown.hidden = true
        if (self.list[row] == "Number Articles")
        {
            updateUI("diversity")
            sortByNumArticles = false
        }
        else
        {
            updateUI("numArticles")
            sortByNumArticles = true
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == self.sortTextbox {
            self.sortDropDown.hidden = false
            //if you dont want the users to se the keyboard type:
            
            textField.endEditing(true)
            
        }
        
        
    }

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Montserrat", size: 8)
//            pickerLabel?.textAlignment = NSTextAlignment.Center
        }
        
        pickerLabel?.text = self.list[row]
        
        return pickerLabel!;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        self.navigationController?.navigationBar.layer.shadowRadius = 4;
        self.navigationController?.navigationBar.layer.shadowOpacity = 1;
        
        self.sortDropDown.hidden = true
        self.sortTextbox.text = "Number Articles"
        updateUI("diversity")
        sortByNumArticles = false
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
            var numArticles: Int?
            var articles = [Article]()
            var canSeeArticles: Bool?
            
            friend.managedObjectContext?.performBlockAndWait {
                name = friend.name
                profileImageFile = friend.picture_filename
                numArticles = friend.articles!.count
                articles = friend.articles!.allObjects as! [Article]
                canSeeArticles = (friend.canSeeArticles == 1)
            }
            cell.nameLabel.text = name
            cell.numArticlesLabel.text = String(numArticles!)
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
        if  segue.identifier == friendSegueIdentifier,
            let destination = segue.destinationViewController as? FriendPieChartViewController,
            cell = sender as? FriendTableViewCell
        {
            destination.articles = cell.articles
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
