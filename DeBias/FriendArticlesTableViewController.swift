//
//  FriendArticlesTableViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/4/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class FriendArticlesTableViewController: UITableViewController {

    var articles = [Article]()
    var typeOfArticle: String?
    var name: String?
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var noArticleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let strSplit = title!.characters.split(" ")
        let firstName = String(strSplit.first!)
        navTitle.title = firstName + " " + typeOfArticle! + " Articles"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        if articles.count == 0 {
            noArticleLabel.text = "No " + typeOfArticle!.lowercaseString + " articles read."
            //STYLE THE LABEL HERE!!
        } else {
            noArticleLabel.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath)
        
        if let cell = c as? ArticleTableViewCell {
            let article = articles[indexPath.row]
            cell.titleLabel?.text = article.title
            cell.authorLabel?.text = article.author
            cell.sourceLabel?.text = article.source
            cell.typeExplanation = article.typeExplanation
            cell.type = article.type
            cell.url = article.url
            cell.title = article.title
            return cell
        }
        return c
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "openWebview"{
                if let cell = sender as? ArticleTableViewCell, let indexPath = tableView.indexPathForCell(cell),
                    let webvc = segue.destinationViewController as? WebViewController {
                    webvc.url = articles[indexPath.row].url
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem
                }
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArticleTableViewCell
        let title = "Article Classification"
        let starter = "The article " + cell.title! + " was classified as "
        let message =  starter + typeOfArticle!.lowercaseString + " because " + cell.typeExplanation!
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        alert.modalInPopover = true;
        
        alert.addAction(UIAlertAction(
            title: "Got it!",
            style: .Default)
        { (action: UIAlertAction) ->  Void in
            }
        )
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
