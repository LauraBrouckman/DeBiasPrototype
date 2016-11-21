//
//  ViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/13/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    @IBOutlet weak var pieChartView: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categories = ["Very Conservative", "Conervative", "Neutral", "Liberal", "Very Liberal"]
        
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
        pieChartView.centerText = "15 Articles"
        pieChartView.drawSliceTextEnabled = false
        var colors: [UIColor] = []
        
        colors = [Colors.darkRed, Colors.lightRed, Colors.purple, Colors.lightBlue, Colors.darkBlue]
        
        pieChartDataSet.colors = colors
        
    }
    
    
    // Add animations to the pie chart where on touch (of certain section) pie chart rotates and label at top displays category name
    // Add button/interaction area where on press it segues to the next screen
}

