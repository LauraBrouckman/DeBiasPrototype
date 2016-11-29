//
//  FriendTableViewController.swift
//  DeBias
//
//  Created by Leslie Kurt on 11/21/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {
    var friends = [Friend]()
    var sortByFriends = true
    
    @IBAction func sortFriends(sender: AnyObject) {
        if (sortByFriends)
        {
            sortFriendsDiversity()
            sortByFriends = false
        }else
        {
            sortFriendsNumArticles()
            sortByFriends = true
        }
        //loadSampleFriends();
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleFriends()
        sortFriendsNumArticles()
        
    }
    
    
    func loadSampleFriends()
    {
        let photo1 = UIImage(named: "default-profile-pic.png")!
        let articles1 = [2,2,2,2,2];
        let friend1 = Friend(name:"Sarah Fisher", profilePic: photo1, articles: articles1)!
        
        let photo2 = UIImage(named:"default-profile-pic.png")!
        let articles2 = [5,3,2,0,0];
        let friend2 = Friend(name:"Tim Wang", profilePic: photo2, articles: articles2)!
        
        let photo3 = UIImage(named:"default-profile-pic.png")!
        let articles3 = [1,2,3,2,1];
        let friend3 = Friend(name:"Linda Kurt", profilePic: photo3, articles: articles3)!
        
        friends += [friend1, friend2, friend3]
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
        return friends.count
    }
    
    func sortFriendsDiversity()
    {
        friends.sortInPlace({ $0.diversity < $1.diversity })
    }

    func sortFriendsNumArticles()
    {
        friends.sortInPlace({ $0.numArticles > $1.numArticles })
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "FriendTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FriendTableViewCell
        
        let friend = friends[indexPath.row]
        
        cell.nameLabel.text = friend.name
        cell.profilePicture.image = friend.profilePic
        cell.rankingLabel.text = String(indexPath.row + 1)
        cell.numArticlesLabel.text = String(friend.numArticles);
        return cell
    }
    
//    let blogSegueIdentifier = "ShowBlogSegue"
//    
//    // MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if  segue.identifier == blogSegueIdentifier,
// 

    let friendSegueIdentifier = "ShowFriendPieChart"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == friendSegueIdentifier,
            let destination = segue.destinationViewController as? FriendPieChartViewController,
            friendIndex = tableView.indexPathForSelectedRow?.row
            {
                destination.name = friends[friendIndex].name
                destination.profilePic = friends[friendIndex].profilePic!
                destination.articles = friends[friendIndex].articles
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
