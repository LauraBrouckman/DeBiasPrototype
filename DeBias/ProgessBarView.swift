//
//  ProgressBarView.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/22/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    
    //These values are set in the viewController to adjust the proportion of the inner
    //Rectangle and the color of the inner rectangle
    var progressBarProportion = 0.0
    var progressBarColor = UIColor.redColor()
    var goalLineProportion = 0.5
    var goal = 0
    var type = "Very conservative"
    var drawLine = true
    var totalBarWidthProportion = 1.0
    var typeLabel = UILabel()
    var goalLabel = UILabel()
    
    let shapeLayer = CAShapeLayer()
    let lineLayer = CAShapeLayer()
    
    override func drawRect(rect: CGRect) {
        //Make outer rectangle
       // let maxBarWidth = bounds.size.width - 60
        let barStartX = bounds.minX + 10
        
       let maxBarWidth = CGFloat(totalBarWidthProportion) * (bounds.size.width - 60)
        

        
        let largeRect = UIBezierPath(roundedRect: CGRectMake(barStartX, bounds.minY + 30, maxBarWidth, 50), cornerRadius: 6)
        UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0).set()
        largeRect.fill()
        largeRect.lineWidth = 1.5
        largeRect.stroke()
  
        // Make line that shows where the goal is set
        layer.addSublayer(shapeLayer)

        if drawLine {
            
            
            let  path = UIBezierPath()
            let  p0 = CGPointMake(barStartX + CGFloat(goalLineProportion) * maxBarWidth, bounds.minY + 30)
            path.moveToPoint(p0)
            
            let p1 = CGPointMake(barStartX + CGFloat(goalLineProportion) * maxBarWidth, bounds.maxY - 20)
            path.addLineToPoint(p1)

            lineLayer.path = path.CGPath
            lineLayer.lineWidth = 1.5
            lineLayer.lineCap = kCALineCapButt
            lineLayer.lineDashPattern = [4.0, 4.0]
            lineLayer.strokeColor = UIColor.blackColor().CGColor
            layer.addSublayer(lineLayer)

        }

        // Add type label
        typeLabel.frame = CGRectMake(barStartX, bounds.minY + 5, bounds.size.width, bounds.minY + 20)
        
        typeLabel.textAlignment = NSTextAlignment.Left
        typeLabel.text = type
        self.addSubview(typeLabel)

        goalLabel.frame = CGRectMake(bounds.minX, bounds.minY, bounds.maxX, bounds.maxY + 10)
        goalLabel.center = CGPointMake(barStartX + CGFloat(goalLineProportion) * maxBarWidth, bounds.maxY - 7)
        goalLabel.textAlignment = NSTextAlignment.Center
        goalLabel.text = String(goal)
        self.addSubview(goalLabel)
        
    }
    
    func prepareForEditing(oldProp: Double, newProp: Double){
        let maxBarWidth = CGFloat(315.0)
        // fill with yellow
        var oldBarWidth = maxBarWidth * CGFloat(oldProp)
        if oldBarWidth > maxBarWidth {
            oldBarWidth = maxBarWidth
        }
        
        let startShape = UIBezierPath(roundedRect: CGRect(x: bounds.minX + 10, y: bounds.minY + 30, width: oldBarWidth, height: 50), cornerRadius: 6).CGPath

        shapeLayer.path = startShape
        shapeLayer.fillColor = progressBarColor.CGColor
        
        // 1
        // begin with a circle with a 50 points radius
        // animation end with a large circle with 500 points radius
        var newBarWidth = maxBarWidth * CGFloat(newProp)
        if newBarWidth > maxBarWidth {
            newBarWidth = maxBarWidth
        }
        
        let endShape = UIBezierPath(roundedRect: CGRect(x: bounds.minX + 10, y: bounds.minY + 30, width: newBarWidth, height: 50), cornerRadius: 6).CGPath
        
        // set initial shape
        shapeLayer.path = startShape
        
        // 2
        // animate the `path`
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = 1 // duration is 1 sec
        // 3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
        animation.fillMode = kCAFillModeBoth // keep to value after finishing
        animation.removedOnCompletion = false // don't remove after finishing
        // 4
        shapeLayer.addAnimation(animation, forKey: animation.keyPath)
        
        setNeedsDisplay()
    }
}
