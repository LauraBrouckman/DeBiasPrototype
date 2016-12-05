//
//  FriendGoalsViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/4/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class FriendGoalsViewController: UIViewController {

    @IBOutlet weak var veryConservativeProgressBar: ProgressBarView!
    @IBOutlet weak var conservativeProgressBar: ProgressBarView!
    @IBOutlet weak var neutralProgressBar: ProgressBarView!
    @IBOutlet weak var liberalProgressBar: ProgressBarView!
    @IBOutlet weak var veryLiberalProgressBar: ProgressBarView!
    
    @IBOutlet weak var veryLiberalButton: UIButton!
    @IBOutlet weak var liberalButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var conservativeButton: UIButton!
    @IBOutlet weak var veryConservativeButton: UIButton!
    
    var articlesRead = [Double]()
    var canSeeArticles = false
    var articles = [Article]()
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateProgressValues()
        
    }
    
    func updateForProgressBar(progressBar: ProgressBarView, key: Int, maxGoal: Double, color: UIColor, type: String) {
        
        progressBar.progressBarProportion = articlesRead[key] / maxGoal
        progressBar.drawLine = false
        progressBar.goalLineProportion = articlesRead[key] / maxGoal
        progressBar.goal = Int(articlesRead[key])
        progressBar.progressBarColor = color
        progressBar.type = type
        progressBar.totalBarWidthProportion = 1.1
    }

    
    func updateProgressValues()
    {
        let maxGoal = articlesRead.maxElement()!
        updateForProgressBar(veryConservativeProgressBar, key: 0, maxGoal: maxGoal, color: Colors.darkRed, type: "Very Conservative Articles")
        updateForProgressBar(conservativeProgressBar, key: 1, maxGoal: maxGoal, color: Colors.lightRed, type: "Conservative Articles")
        updateForProgressBar(neutralProgressBar, key: 2, maxGoal: maxGoal, color: Colors.purple, type: "Neutral Articles")
        updateForProgressBar(liberalProgressBar, key: 3, maxGoal: maxGoal, color: Colors.lightBlue, type: "Liberal Articles")
        updateForProgressBar(veryLiberalProgressBar, key: 4, maxGoal: maxGoal, color: Colors.darkBlue, type: "Very Liberal Articles")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticlesOfType(type: String) -> [Article] {
        var typeArticles = [Article]()
        for article in self.articles {
            if article.type == type {
                typeArticles.append(article)
            }
        }
        return typeArticles
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if !self.canSeeArticles {
            let title = "Can not view articles"
            let message = name! + " does not allowed other users to see the articles that they have read."
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
        
        else if let identifier = segue.identifier {
            if identifier == "showFriendArticles" {
                if let button = sender as? UIButton, let articlevc = segue.destinationViewController as? FriendArticlesTableViewController {
                    articlevc.name = self.name
                    switch button {
                    case veryConservativeButton:
                        articlevc.typeOfArticle = "Very Conservative"
                        articlevc.articles = getArticlesOfType("veryConservative")
                    case conservativeButton:
                        articlevc.typeOfArticle = "Conservative"
                        articlevc.articles = getArticlesOfType("conservative")
                    case neutralButton:
                        articlevc.typeOfArticle = "Neutral"
                        articlevc.articles = getArticlesOfType("neutral")
                    case liberalButton:
                        articlevc.typeOfArticle = "Liberal"
                        articlevc.articles = getArticlesOfType("liberal")
                    case veryLiberalButton:
                        articlevc.typeOfArticle = "Very Liberal"
                        articlevc.articles = getArticlesOfType("veryLiberal")
                    default: break
                    }
                }
            }
        }
    }

}
