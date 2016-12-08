//
//  FriendPieChartViewController.swift
//  DeBias
//
//  Created by Leslie Kurt on 11/28/16.
//  Copyright © 2016 debias. All rights reserved.
//



import UIKit
import Charts

class FriendPieChartViewController: UIViewController
{
    var name = String()
    var articles = [Article]()
    var canSeeArticles = false
    var articlesRead = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var navTitle: UINavigationItem!
    //@IBOutlet weak var navTitle: UINavigationItem!
    //    @IBOutlet weak var navTitle: UINavigationItem!
    //@IBOutlet weak var navTitle: UINavigationItem!
    //@IBOutlet weak var navTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strSplit = name.characters.split(" ")
        let firstName = String(strSplit.first!)
        if firstName == "Me" {
            navTitle.title = "My Overview"
        } else {
            navTitle.title = firstName + "'s Overview"
        }
        
        let categories = ["Very Conservative", "Conservative", "Neutral", "Liberal", "Very Liberal"]
        detailButton.backgroundColor = UIColor.clearColor()
        detailButton.layer.cornerRadius = 6
        detailButton.layer.borderWidth = 1.5
        detailButton.layer.borderColor = UIColor.grayColor().CGColor
        for article in articles {
            switch article.type! {
            case "veryConservative":
                articlesRead[0] += 1
            case "conservative":
                articlesRead[1] += 1
            case "neutral":
                articlesRead[2] += 1
            case "liberal":
                articlesRead[3] += 1
            case "veryLiberal":
                articlesRead[4] += 1
            default: break
            }
        }
        setChart(categories, values: articlesRead)
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
        if let identifier = segue.identifier {
            if identifier == "showFriendGoals"{
                if let goalsvc = segue.destinationViewController as? FriendGoalsViewController {
                    goalsvc.articlesRead = self.articlesRead
                    goalsvc.articles = self.articles
                    goalsvc.canSeeArticles = self.canSeeArticles
                    goalsvc.name = self.navTitle.title
                    //goalsvc.name = self.firstName
                    
                }
            }
        }
        
    }
    
}
