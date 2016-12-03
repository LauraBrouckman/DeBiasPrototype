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
    
//    @IBOutlet weak var navTitle: UINavigationItem!
//    
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
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        self.navigationController?.navigationBar.layer.shadowRadius = 4;
        self.navigationController?.navigationBar.layer.shadowOpacity = 1;
        
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
        return friends.count + 1
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

        if (indexPath.row == 0)
        {
            let cellIdentifier1 = "FriendToolbarViewCell"
            let cell1 = tableView.dequeueReusableCellWithIdentifier(cellIdentifier1, forIndexPath: indexPath) as! FriendToolbarViewCell
            tableView.rowHeight = 40
            return cell1
            
        }
        tableView.rowHeight = 90
        let cellIdentifier = "FriendTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FriendTableViewCell
        
        let friend = friends[indexPath.row - 1]
        
        cell.nameLabel.text = friend.name
        cell.profilePicture.image = friend.profilePic
        cell.rankingLabel.text = String(indexPath.row)
        cell.numArticlesLabel.text = String(friend.numArticles);
        return cell
    }

    let friendSegueIdentifier = "ShowFriendPieChart"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == friendSegueIdentifier,
            let destination = segue.destinationViewController as? FriendPieChartViewController,
            let friendIndex = tableView.indexPathForSelectedRow?.row
            {
                destination.name = friends[friendIndex].name
                destination.profilePic = friends[friendIndex].profilePic!
                destination.articles = friends[friendIndex].articles
            }
    }
    
}
