//
//  ViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/13/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
//import Charts
import CoreData

class PieChartViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var detailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let categories = ["Very Conservative", "Conservative", "Neutral", "Liberal", "Very Liberal"]
        
        /* Get the number of articles read for each type from user defaults */
        var articlesRead = Array<Double>()
        for type in UserDefaults.articleTypes {
            if let goal = UserDefaults.getArticleRead(type) {
                articlesRead.append(Double(goal))
            } else {
                articlesRead.append(0.0)
            }
        }
        
        /* Set up the pie chart */
        setChart(categories, values: articlesRead)
        
        detailsButton.backgroundColor = UIColor.clearColor()
        detailsButton.layer.cornerRadius = 6
        detailsButton.layer.borderWidth = 1.5
        detailsButton.layer.borderColor = UIColor.grayColor().CGColor
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        self.navigationController?.navigationBar.layer.shadowRadius = 4;
        self.navigationController?.navigationBar.layer.shadowOpacity = 1;
        
        //self.tabBarController?.tabBar.selectedItem?.selectedImage. = Colors.darkRed
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 240.0/255, green: 240/255, blue: 240/255, alpha: 1.0)
        self.tabBarController?.tabBar.tintColor = UIColor(red: 28.0/255, green: 190/255, blue: 124/255, alpha: 1.0)
        
        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")
        if launchedBefore  {
        } else {
            addCoreData()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
        }
    }
    
    func shuffleArray(list: [AnyObject]) -> [AnyObject]{
        var tempList = list
        if tempList.count < 2 {
            return tempList
        }
        
        for i in 0 ..< tempList.count {
            let j = Int(arc4random_uniform(UInt32(tempList.count - i))) + i
            guard i != j else { continue }
            swap(&tempList[i], &tempList[j])
        }
        return tempList
    }
    
    func addCoreData() {
        addArticles()
        let veryConservataiveArticles = getVeryConservativeArticles()
        let conservativeArticles =      getConservativeArticles()
        let neutralArticles =           getNeutralArticles()
        let liberalArticles =           getLiberalArticles()
        let veryLiberalArticles =       getVeryLiberalArticles()
        for a in veryConservataiveArticles {
            UserDefaults.addArticleToList(a["title"]!, articleType: "veryConservative")
        }
        for a in conservativeArticles {
            UserDefaults.addArticleToList(a["title"]!, articleType: "conservative")
        }
        for a in neutralArticles {
            UserDefaults.addArticleToList(a["title"]!, articleType: "neutral")
        }
        for a in liberalArticles {
            UserDefaults.addArticleToList(a["title"]!, articleType: "liberal")
        }
        for a in veryLiberalArticles {
            UserDefaults.addArticleToList(a["title"]!, articleType: "veryLiberal")
        }
        
        
        for a in (veryConservataiveArticles + conservativeArticles + neutralArticles + liberalArticles + veryLiberalArticles) {
            self.managedObjectContext?.performBlock { [weak weakSelf = self] in
                Article.addArticleToDB(a["title"]!, author: a["author"]!, type: a["type"]!, source: a["source"]!, typeExplanation: a["typeExplanation"]!, url: a["url"]!, imageFile: a["image"]!, inManagedObjectContext: (weakSelf?.managedObjectContext)!)
                do {
                    try (weakSelf?.managedObjectContext)!.save()
                } catch let error {
                    print(error)
                }
                
            }
        }
        
        var articles = veryConservataiveArticles + conservativeArticles + neutralArticles + liberalArticles + veryLiberalArticles as [AnyObject]
        let friends = ["Serena VDW", "Chuck Bass", "Kanye West", "Justin Bieber", "Harry Potter", "Ron Weasley", "Hermione Granger", "Bart Simpson", "Taylor Swift", "Barack Obama", "Sarah Brown", "Jeff Johnson", "Beyonce"]
        let pictures = ["Serena.png", "Chuck.png", "Kanye.png", "Justin.png", "HarryPotter.png", "Ron.png", "Hermione.png", "Bart.png", "Taylor.png", "Obama.png", "default-profile-pic.png", "default-profile-pic.png", "Beyonce.png"]
        for i in 0..<friends.count {
            //            // Choose random number of articles
            let f = friends[i]
            var friendArticles = [AnyObject]()
            articles = shuffleArray(articles)
            let numArticles = Int(arc4random_uniform(24))
            var friendArticleTypes = [0, 0, 0, 0, 0]
            for i in 0..<numArticles {
                friendArticles.append(articles[i]["title"]!!)
                switch articles[i]["type"]! as! String {
                case "veryConservative":
                    friendArticleTypes[0] += 1
                case "conservative":
                    friendArticleTypes[1] += 1
                case "neutral":
                    friendArticleTypes[2] += 1
                case "liberal":
                    friendArticleTypes[3] += 1
                case "veryLiberal":
                    friendArticleTypes[4] += 1
                default: break
                }
            }
            let isFriend = Int(arc4random_uniform(2))
            let canSeeArticles = (Int(arc4random_uniform(2)) == 1)
            let diversity = getDiversity(friendArticleTypes, numArticles: friendArticles.count)
            self.managedObjectContext?.performBlock { [weak weakSelf = self] in
                var friendArticleObjects = [Article]()
                for a in friendArticles {
                    let article = Article.getArticleByName(a as! String, inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
                    friendArticleObjects.append(article!)
                }
                User.addUserToDB(f, friend: (isFriend == 1), canSeeArticles: canSeeArticles, picture_filename: pictures[i], diversity: diversity, articles: friendArticleObjects, inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
                do {
                    try (weakSelf?.managedObjectContext)!.save()
                } catch let error {
                    print(error)
                }
                
            }
        }
        
        //Add yourself as your own "friend" so that you show up in the friends list
        var myArticles = [String]()
        var myArticlesRead = [0, 0, 0, 0, 0]
        for a in UserDefaults.getArticleList("veryConservative")! {
            myArticles.append(a)
            myArticlesRead[0] += 1
        }
        for a in UserDefaults.getArticleList("conservative")! {
            myArticles.append(a)
            myArticlesRead[1] += 1
        }
        for a in UserDefaults.getArticleList("neutral")! {
            myArticles.append(a)
            myArticlesRead[2] += 1
        }
        for a in UserDefaults.getArticleList("liberal")! {
            myArticles.append(a)
            myArticlesRead[3] += 1
        }
        for a in UserDefaults.getArticleList("veryLiberal")! {
            myArticles.append(a)
            myArticlesRead[4] += 1
        }
        let diversity = getDiversity(myArticlesRead, numArticles: myArticles.count)
        managedObjectContext?.performBlock { [weak weakSelf = self] in
            var myArticleObjects = [Article]()
            for a in myArticles {
                let article = Article.getArticleByName(a as! String, inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
                myArticleObjects.append(article!)
            }
            User.addUserToDB("Me", friend: true, canSeeArticles: true, picture_filename: "default-profile-pic.png", diversity: diversity, articles: myArticleObjects, inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
            do {
                try (weakSelf?.managedObjectContext)!.save()
            } catch let error {
                print(error)
            }
            
        }
    }
    
    func getDiversity(articles: Array<Int>, numArticles: Int) -> Float
    {
        let mean = Float(Float(numArticles) / 5)
        var variation = Float(0.0)
        for i in 0..<articles.count {
            variation += Float(pow(mean - Float(articles[i]), 2))
        }
        return variation / 5
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var sum = 0
        for i in 0 ..< values.count {
            sum = sum + Int(values[i])
        }
        pieChartView.centerText = String(sum) + " Articles"
        
        pieChartView.drawSliceTextEnabled = false
        var colors: [UIColor] = []
        
        colors = [Colors.darkRed, Colors.lightRed, Colors.purple, Colors.lightBlue, Colors.darkBlue]
        
        pieChartDataSet.colors = colors
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
    // Add animations to the pie chart where on touch (of certain section) pie chart rotates and label at top displays category name
    // Add button/interaction area where on press it segues to the next screen
}

