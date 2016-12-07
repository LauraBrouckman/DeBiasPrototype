//
//  ArticleTableViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/29/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import CoreData

class ArticleTableViewController: CoreDataTableViewController {
    
    var typeOfArticle: String?
    
    @IBOutlet weak var noArticlesLabel: UILabel!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateUI()
        }
    }
    
    var urls = [String]()
    
    private func updateUI() {
        if typeOfArticle?.characters.count > 0
        {
            let articles = UserDefaults.getArticleList(typeOfArticle!)!
            
            //Set size of urls array
            for _ in articles
            {
                urls.append("")
            }
            
            if let context = managedObjectContext {
                let request = NSFetchRequest(entityName: "Article")
                request.predicate = NSPredicate(format: "title in %@", articles)
                request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
                fetchedResultsController = NSFetchedResultsController(
                    fetchRequest: request,
                    managedObjectContext: context,
                    sectionNameKeyPath: nil,
                    cacheName: nil
                )
            } else {
                fetchedResultsController = nil
            }
        }
    }
    
    let typeToName: Dictionary<String, String> =
        [
            "veryConservative": "very conservative",
            "conservative": "conservative",
            "neutral": "neutral",
            "liberal": "liberal",
            "veryLiberal": "very liberal"
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        navTitle.title = typeOfArticle! + " List"
        if tableView.numberOfRowsInSection(1) == 0 {
            noArticlesLabel.text = "You have not read any " + typeToName[typeOfArticle!]! + " articles"
            //STYLE LABEL HERE
        } else {
            noArticlesLabel.text = ""
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        if let article = fetchedResultsController?.objectAtIndexPath(indexPath) as? Article {
            var title: String?
            var author: String?
            var source: String?
            var type: String?
            var typeExplanation: String?
            var url: String?
            var imageFile: String?
            article.managedObjectContext?.performBlockAndWait {
                title = article.title
                author = article.author
                source = article.source
                type = article.type
                typeExplanation = article.typeExplanation
                url = article.url
                imageFile = article.imageFile
            }
            cell.titleLabel?.text = title
            cell.authorLabel?.text = author
            cell.url = url
            cell.type = type
            cell.typeExplanation = typeExplanation
            cell.sourceLabel?.text = source
            cell.title = title
            cell.articlePreviewImage.image = UIImage(named: imageFile!)
            urls[indexPath.row] = url!
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArticleTableViewCell
        let title = "Article Classification"
        let starter = "The article " + cell.title! + " was classified as "
        let message =  starter + typeToName[cell.type!]! + " because " + cell.typeExplanation!
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "openWebview"{
                if let cell = sender as? ArticleTableViewCell, let indexPath = tableView.indexPathForCell(cell),
                    let webvc = segue.destinationViewController as? WebViewController {
                    webvc.url = urls[indexPath.row]
                                let backItem = UIBarButtonItem()
                                backItem.title = ""
                                navigationItem.backBarButtonItem = backItem
                }
            }
        }
        
    }
    
}
