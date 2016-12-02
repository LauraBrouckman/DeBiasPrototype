//
//  GoalsViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/22/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit
import CoreData

class GoalsViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    var managedObjectContext: NSManagedObjectContext? =
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    @IBOutlet weak var veryConservativeProgressBar: ProgressBarView!
    @IBOutlet weak var conservativeProgressBar: ProgressBarView!
    @IBOutlet weak var neutralProgressBar: ProgressBarView!
    @IBOutlet weak var liberalProgressBar: ProgressBarView!
    @IBOutlet weak var veryLiberalProgressBar: ProgressBarView!
    
    @IBOutlet weak var badgesButton: UIButton!
    @IBOutlet weak var trendsButton: UIButton!
    
    @IBOutlet weak var veryConservativeButton: UIButton!
    @IBOutlet weak var conservativeButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var liberalButton: UIButton!
    @IBOutlet weak var veryLiberalButton: UIButton!
    
    let pickerData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProgressValues()
        
        badgesButton.backgroundColor = UIColor.clearColor()
        badgesButton.layer.cornerRadius = 6
        badgesButton.layer.borderWidth = 1.5
        badgesButton.layer.borderColor = UIColor.grayColor().CGColor
        
        trendsButton.backgroundColor = UIColor.clearColor()
        trendsButton.layer.cornerRadius = 6
        trendsButton.layer.borderWidth = 1.5
        trendsButton.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    func updateForProgressBar(progressBar: ProgressBarView, key: String, maxGoal: Double, color: UIColor, type: String, goals: Dictionary<String, Double>, read: Dictionary<String, Double>) {
        //Type 1: This way, the max goal is the width of the bar and all other bars are prop. there is a line indicating where the specific goal is set.
                progressBar.progressBarProportion = read[key]! / maxGoal
                progressBar.goalLineProportion = goals[key]! / maxGoal
        //        //Type 2: his way, the bar width is set to the proportional specific goal and is filled based on articles read
//                progressBar.progressBarProportion = read[key]! / goals[key]!
//                progressBar.drawLine = false
//                progressBar.goalLineProportion = 1.0
        
        //Type 3: his way, the bar width is set directly to goal and filled based on articles
//        progressBar.drawLine = false
//        progressBar.progressBarProportion = read[key]! / goals[key]!
//        progressBar.totalBarWidthProportion = goals[key]! / maxGoal
//        progressBar.goalLineProportion = 1.0
//        
        progressBar.progressBarColor = color
        progressBar.goal = Int(goals[key]!)
        progressBar.type = type
    }
    
    func updateProgressValues()
    {
        let goals = [
            "veryConservative": Double(UserDefaults.getArticleGoal("veryConservative")!),
            "conservative": Double(UserDefaults.getArticleGoal("conservative")!),
            "neutral": Double(UserDefaults.getArticleGoal("neutral")!),
            "liberal": Double(UserDefaults.getArticleGoal("liberal")!),
            "veryLiberal": Double(UserDefaults.getArticleGoal("veryLiberal")!)
        ]
        
        let read = [
            "veryConservative": Double(UserDefaults.getArticleRead("veryConservative")!),
            "conservative": Double(UserDefaults.getArticleRead("conservative")!),
            "neutral": Double(UserDefaults.getArticleRead("neutral")!),
            "liberal": Double(UserDefaults.getArticleRead("liberal")!),
            "veryLiberal": Double(UserDefaults.getArticleRead("veryLiberal")!)
        ]

        let maxGoal = goals.values.maxElement()!
        updateForProgressBar(veryConservativeProgressBar, key: "veryConservative", maxGoal: maxGoal, color: Colors.darkRed, type: "Very Conservative Articles", goals: goals, read: read)
        updateForProgressBar(conservativeProgressBar, key: "conservative", maxGoal: maxGoal, color: Colors.lightRed, type: "Conservative Articles", goals: goals, read: read)
        updateForProgressBar(neutralProgressBar, key: "neutral", maxGoal: maxGoal, color: Colors.purple, type: "Neutral Articles", goals: goals, read: read)
        updateForProgressBar(liberalProgressBar, key: "liberal", maxGoal: maxGoal, color: Colors.lightBlue, type: "Liberal Articles", goals: goals, read: read)
        updateForProgressBar(veryLiberalProgressBar, key: "veryLiberal", maxGoal: maxGoal, color: Colors.darkBlue, type: "Very Liberal Articles", goals: goals, read: read)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
    
    func addAlert(articleTypeName: String, articleType: String){
        
        // create the alert
        let title = "Edit goal for " + articleTypeName + " articles"
        let currentGoal = UserDefaults.getArticleGoal(articleType)!
        let message = "Current goal: " + String(currentGoal) + "\n\n\n\n\n\n\n"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        alert.modalInPopover = true;
        
        
        // now create our custom view - we are using a container view which can contain other views
        let containerViewWidth = 250
        let containerViewHeight = 120
        let containerFrame = CGRectMake(10, 70, CGFloat(containerViewWidth), CGFloat(containerViewHeight));
        //let containerView: UIView = UIView(frame: containerFrame);
        let pickerView = UIPickerView(frame: containerFrame)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(currentGoal, inComponent: 0, animated: true)
        alert.view.addSubview(pickerView)
        
        alert.addAction(UIAlertAction(
            title: "Set",
            style: .Default)
        {  [weak weakSelf = self] (action: UIAlertAction) ->  Void in
            let newGoal = Int((weakSelf?.pickerData[pickerView.selectedRowInComponent(0)])!)
            UserDefaults.setArticleGoal(newGoal!, articleType: articleType)
            weakSelf?.updateProgressValues()
            weakSelf?.veryLiberalProgressBar.setNeedsDisplay()
            weakSelf?.liberalProgressBar.setNeedsDisplay()
            weakSelf?.neutralProgressBar.setNeedsDisplay()
            weakSelf?.conservativeProgressBar.setNeedsDisplay()
            weakSelf?.veryConservativeProgressBar.setNeedsDisplay()
            }
        )
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .Default)
        {  (action: UIAlertAction) ->  Void in
            }
        )
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func editVeryConservativeGoal(sender: UIButton) {
        addAlert("very conservative", articleType: "veryConservative")
    }
    
    @IBAction func editConservativeGoal(sender: UIButton) {
        addAlert("conservative", articleType: "conservative")
    }
    
    @IBAction func editNeutralGoal(sender: UIButton) {
        addAlert("neutral", articleType: "neutral")
        
    }
    
    @IBAction func editLiberalGoal(sender: UIButton) {
        addAlert("liberal", articleType: "liberal")
        
    }
    
    @IBAction func editVeryLiberalGoal(sender: UIButton) {
        addAlert("very liberal", articleType: "veryLiberal")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "showArticles" {
                if let button = sender as? UIButton, let articlevc = segue.destinationViewController as? ArticleTableViewController {
                    articlevc.managedObjectContext = managedObjectContext
                    switch button {
                    case veryConservativeButton:
                        articlevc.typeOfArticle = "veryConservative"
                    case conservativeButton:
                        articlevc.typeOfArticle = "conservative"
                    case neutralButton:
                        articlevc.typeOfArticle = "neutral"
                    case liberalButton:
                        articlevc.typeOfArticle = "liberal"
                    case veryLiberalButton:
                        articlevc.typeOfArticle = "veryLiberal"
                    default: break
                    }
                }
            }
        }
    }
    
}
