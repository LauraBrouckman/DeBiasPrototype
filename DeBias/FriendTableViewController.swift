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
    
//        @IBOutlet weak var navTitle: UINavigationItem!
    
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    @IBAction func switchSort(sender: UISwitch) {
            if (sortByNumArticles)
            {
                print("Sort by numArticles")
                updateUI("diversity")
                sortByNumArticles = false
            }else
            {
                print("sort by diversity")
                updateUI("numArticles")
                sortByNumArticles = true
            }
          //  self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navTitle.title = "Friends"
        updateUI("numArticles")
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
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
