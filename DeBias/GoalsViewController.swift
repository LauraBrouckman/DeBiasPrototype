//
//  GoalsViewController.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/22/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class GoalsViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var veryConservativeProgressBar: ProgressBarView!
    @IBOutlet weak var conservativeProgressBar: ProgressBarView!
    @IBOutlet weak var neutralProgressBar: ProgressBarView!
    @IBOutlet weak var liberalProgressBar: ProgressBarView!
    @IBOutlet weak var veryLiberalProgressBar: ProgressBarView!
    
    @IBOutlet weak var trendsButton: UIButton!
    @IBOutlet weak var badgesButton: UIButton!
    
    let pickerData = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgressValues()
        
        trendsButton.backgroundColor = UIColor.clearColor()
        trendsButton.layer.cornerRadius = 6
        trendsButton.layer.borderWidth = 1.5
        trendsButton.layer.borderColor = UIColor.grayColor().CGColor
        
        badgesButton.backgroundColor = UIColor.clearColor()
        badgesButton.layer.cornerRadius = 6
        badgesButton.layer.borderWidth = 1.5
        badgesButton.layer.borderColor = UIColor.grayColor().CGColor
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
        

        veryConservativeProgressBar.progressBarColor = Colors.darkRed
        veryConservativeProgressBar.progressBarProportion = read["veryConservative"]! / maxGoal
        veryConservativeProgressBar.goalLineProportion = goals["veryConservative"]! / maxGoal
        veryConservativeProgressBar.goal = Int(goals["veryConservative"]!)
        veryConservativeProgressBar.type = "Very Conservative Articles"
        
        conservativeProgressBar.progressBarProportion = read["conservative"]! / maxGoal
        conservativeProgressBar.progressBarColor = Colors.lightRed
        conservativeProgressBar.goalLineProportion = goals["conservative"]! / maxGoal
        conservativeProgressBar.goal = Int(goals["conservative"]!)
        conservativeProgressBar.type = "Conservative Articles"
        
        neutralProgressBar.progressBarProportion = read["neutral"]! / maxGoal
        neutralProgressBar.progressBarColor = Colors.purple
        neutralProgressBar.goalLineProportion = goals["neutral"]! / maxGoal
        neutralProgressBar.goal = Int(goals["neutral"]!)
        neutralProgressBar.type = "Neutral Articles"
        
        liberalProgressBar.progressBarProportion = read["liberal"]! / maxGoal
        liberalProgressBar.progressBarColor = Colors.lightBlue
        liberalProgressBar.goalLineProportion = goals["liberal"]! / maxGoal
        liberalProgressBar.goal = Int(goals["liberal"]!)
        liberalProgressBar.type = "Liberal Articles"
        
        veryLiberalProgressBar.progressBarProportion = read["veryLiberal"]! / maxGoal
        veryLiberalProgressBar.progressBarColor = Colors.darkBlue
        veryLiberalProgressBar.goalLineProportion = goals["veryLiberal"]! / maxGoal
        veryLiberalProgressBar.goal = Int(goals["veryLiberal"]!)
        veryLiberalProgressBar.type = "Very Liberal Articles"
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
        let message = "Current goal: " + String(currentGoal) + "\n\n\n\n\n\n\n\n"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        alert.modalInPopover = true;
        
        
        // now create our custom view - we are using a container view which can contain other views
        let containerViewWidth = 250
        let containerViewHeight = 150
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
