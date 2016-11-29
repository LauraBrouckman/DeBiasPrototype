//
//  TrendsViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/22/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import Charts

class TrendsViewController: UIViewController {

    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let weeks = ["Nov 6-12", "Nov 13-19", "Nov 20-26"]
        let longTermData = UserDefaults.getAllLongTermData()
        
        var veryConservativeArticlesRead = [Double]()
        var conservativeArticlesRead = [Double]()
        var neutralArticlesRead = [Double]()
        var liberalArticlesRead = [Double]()
        var veryLiberalArticlesRead = [Double]()
        
        for i in 0 ..< 3 {
            veryConservativeArticlesRead.append(Double(longTermData[i]["veryConservative"]!))
            conservativeArticlesRead.append(Double(longTermData[i]["conservative"]!))
            neutralArticlesRead.append(Double(longTermData[i]["neutral"]!))
            liberalArticlesRead.append(Double(longTermData[i]["liberal"]!))
            veryLiberalArticlesRead.append(Double(longTermData[i]["veryLiberal"]!))
        }
        
        let allData = [veryConservativeArticlesRead, conservativeArticlesRead, neutralArticlesRead, liberalArticlesRead, veryLiberalArticlesRead]
        
        setChartBarGroupDataSet(weeks, data: allData)
    }
    
    func setChartBarGroupDataSet(dataPoints: [String], data: [[Double]]) {
        
        var veryConservativeDataEntries: [BarChartDataEntry] = []
        var conservativeDataEntries: [BarChartDataEntry] = []
        var neutralDataEntries: [BarChartDataEntry] = []
        var liberalDataEntries: [BarChartDataEntry] = []
        var veryLiberalDataEntries: [BarChartDataEntry] = []

        
        for i in 0..<data[0].count {
            veryConservativeDataEntries.append(BarChartDataEntry(value: data[0][i], xIndex: i))
            conservativeDataEntries.append(BarChartDataEntry(value: data[1][i], xIndex: i))
            neutralDataEntries.append(BarChartDataEntry(value: data[2][i], xIndex: i))
            liberalDataEntries.append(BarChartDataEntry(value: data[3][i], xIndex: i))
            veryLiberalDataEntries.append(BarChartDataEntry(value: data[4][i], xIndex: i))
        }
        
        
        let veryConservativeDataSet = BarChartDataSet(yVals: veryConservativeDataEntries, label: "Very Conservative")
        let conservativeDataSet = BarChartDataSet(yVals: conservativeDataEntries, label: "Conservative")
        let neutralDataSet = BarChartDataSet(yVals: neutralDataEntries, label: "Neutral")
        let liberalDataSet = BarChartDataSet(yVals: liberalDataEntries, label: "Liberal")
        let veryLiberalDataSet = BarChartDataSet(yVals: veryLiberalDataEntries, label: "Very Liberal")
        
        veryConservativeDataSet.colors =  [Colors.darkRed]
        conservativeDataSet.colors =  [Colors.lightRed]
        neutralDataSet.colors = [Colors.purple]
        liberalDataSet.colors = [Colors.lightBlue]
        veryLiberalDataSet.colors = [Colors.darkBlue]
        
        let dataSets: [BarChartDataSet] = [veryConservativeDataSet,conservativeDataSet, neutralDataSet, liberalDataSet, veryLiberalDataSet]
        
        let data = BarChartData(xVals: dataPoints, dataSets: dataSets)
        barChart.data = data
        barChart.descriptionText = ""
        barChart.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
        barChart.pinchZoomEnabled = true
        barChart.drawGridBackgroundEnabled = false
        barChart.xAxis.labelPosition = .Bottom
        barChart.leftAxis.labelFont = UIFont(name: "Helvetica", size: CGFloat(15.0))!
        barChart.xAxis.labelFont = UIFont(name: "Helvetica", size: CGFloat(13.0))!


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
