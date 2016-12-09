//
//  FriendTableViewCell.swift
//  DeBias
//
//  Created by Leslie Kurt on 11/21/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
//import Charts

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var canSeeArticles = false
    
    var articles: [Article]? {
        didSet {
            updatePieChart()
        }
    }
    var articlesRead = [0.0, 0.0, 0.0, 0.0, 0.0]

    @IBOutlet weak var pieChartView: PieChartView!
    
    override func awakeFromNib() {
        updatePieChart()
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        updatePieChart()
    }
    
    
    func updatePieChart() {
        articlesRead = [0.0, 0.0, 0.0, 0.0, 0.0]
        let categories = ["Very Conservative", "Conservative", "Neutral", "Liberal", "Very Liberal"]
        if let a = articles {
            for article in a {
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
        pieChartView.rotationEnabled = false
        pieChartView.highlightPerTapEnabled = false
        pieChartView.centerText = String(articles!.count)
        pieChartView.drawSliceTextEnabled = false
        pieChartView.legend.enabled = false
        var colors: [UIColor] = []
        
        colors = [Colors.darkRed, Colors.lightRed, Colors.purple, Colors.lightBlue, Colors.darkBlue]
        
        pieChartDataSet.colors = colors
    }
    

}
