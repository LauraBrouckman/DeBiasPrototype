//
//  ViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/13/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import Charts
import CoreData



class PieChartViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var detailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load")
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
        
        addArticleData()
    }
 
    func addArticleData() {
        
        let veryConservataiveArticles = getVeryConservativeArticles()
        let conservativeArticles =      getConservativeArticles()
        let neutralArticles =           getNeutralArticles()
        let liberalArticles =           getLiberalArticles()
        let veryLiberalArticles =       getVeryLiberalArticles()
        for a in (veryConservataiveArticles + conservativeArticles + neutralArticles + liberalArticles + veryLiberalArticles) {
            managedObjectContext?.performBlock { [weak weakSelf = self] in
                let article = Article.addArticleToDB(a["title"]!, author: a["author"]!, type: a["type"]!, source: a["source"]!, typeExplanation: a["typeExplanation"]!, url: a["url"]!, inManagedObjectContext: (weakSelf?.managedObjectContext)!)
                                do {
                                    try (weakSelf?.managedObjectContext)!.save()
                                } catch let error {
                                    print(error)
                                }
                                
            }
        }
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
    
    
    // Add animations to the pie chart where on touch (of certain section) pie chart rotates and label at top displays category name
    // Add button/interaction area where on press it segues to the next screen
}

