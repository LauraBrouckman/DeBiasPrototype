//
//  PieRadarChartViewBase.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 4/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics

#if !os(OSX)
    import UIKit
#endif

/// Base class of PieChartView and RadarChartView.
public class PieRadarChartViewBase: ChartViewBase
{
    /// holds the normalized version of the current rotation angle of the chart
    private var _rotationAngle = CGFloat(270.0)
    
    /// holds the raw version of the current rotation angle of the chart
    private var _rawRotationAngle = CGFloat(270.0)
    
    /// flag that indicates if rotation is enabled or not
    public var rotationEnabled = true
    
    /// Sets the minimum offset (padding) around the chart, defaults to 0.0
    public var minOffset = CGFloat(0.0)
    
    /// iOS && OSX only: Enabled multi-touch rotation using two fingers.
    private var _rotationWithTwoFingers = false
    
    private var _tapGestureRecognizer: NSUITapGestureRecognizer!
    #if !os(tvOS)
    private var _rotationGestureRecognizer: NSUIRotationGestureRecognizer!
    #endif
    
    
    public var articleLabel = UILabel()
        
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    deinit
    {
        stopDeceleration()
    }
    
    internal override func initialize()
    {
        super.initialize()
        
        _tapGestureRecognizer = NSUITapGestureRecognizer(target: self, action: #selector(PieRadarChartViewBase.tapGestureRecognized(_:)))
        
        self.addGestureRecognizer(_tapGestureRecognizer)

        #if !os(tvOS)
            _rotationGestureRecognizer = NSUIRotationGestureRecognizer(target: self, action: #selector(PieRadarChartViewBase.rotationGestureRecognized(_:)))
            self.addGestureRecognizer(_rotationGestureRecognizer)
            _rotationGestureRecognizer.enabled = rotationWithTwoFingers
        #endif
    }
    
    internal override func calcMinMax()
    {
        _xAxis.axisRange = Double((_data?.xVals.count ?? 0) - 1)
    }
    
    
    public override func notifyDataSetChanged()
    {
        calcMinMax()
        
        if let data = _data where _legend !== nil
        {
            _legendRenderer.computeLegend(data)
        }
        
        calculateOffsets()
        
        setNeedsDisplay()
    }
  
    internal override func calculateOffsets()
    {
        var legendLeft = CGFloat(0.0)
        var legendRight = CGFloat(0.0)
        var legendBottom = CGFloat(0.0)
        var legendTop = CGFloat(0.0)

        if _legend != nil && _legend.enabled && !_legend.drawInside
        {
            var fullLegendWidth = min(_legend.neededWidth, _viewPortHandler.chartWidth * _legend.maxSizePercent)
            fullLegendWidth += _legend.formSize + _legend.formToTextSpace
            
            switch _legend.orientation
            {
            case .Vertical:
                
                var xLegendOffset: CGFloat = 0.0
                
                if _legend.horizontalAlignment == .Left
                    || _legend.horizontalAlignment == .Right
                {
                    if _legend.verticalAlignment == .Center
                    {
                        // this is the space between the legend and the chart
                        let spacing = CGFloat(13.0)
                        
                        xLegendOffset = fullLegendWidth + spacing
                    }
                    else
                    {
                        // this is the space between the legend and the chart
                        let spacing = CGFloat(8.0)
                        
                        let legendWidth = fullLegendWidth + spacing
                        let legendHeight = _legend.neededHeight + _legend.textHeightMax
                        
                        let c = self.midPoint
                        
                        let bottomX = _legend.horizontalAlignment == .Right
                            ? self.bounds.width - legendWidth + 15.0
                            : legendWidth - 15.0
                        let bottomY = legendHeight + 15
                        let distLegend = distanceToCenter(x: bottomX, y: bottomY)
                        
                        let reference = getPosition(center: c, dist: self.radius,
                                                    angle: angleForPoint(x: bottomX, y: bottomY))
                        
                        let distReference = distanceToCenter(x: reference.x, y: reference.y)
                        let minOffset = CGFloat(5.0)
                        
                        if (bottomY >= c.y
                            && self.bounds.height - legendWidth > self.bounds.width)
                        {
                            xLegendOffset = legendWidth
                        }
                        else if (distLegend < distReference)
                        {
                            let diff = distReference - distLegend
                            xLegendOffset = minOffset + diff
                        }
                    }
                }
                
                switch _legend.horizontalAlignment
                {
                case .Left:
                    legendLeft = xLegendOffset
                    
                case .Right:
                    legendRight = xLegendOffset
                    
                case .Center:
                    
                    switch _legend.verticalAlignment
                    {
                    case .Top:
                        legendTop = min(_legend.neededHeight, _viewPortHandler.chartHeight * _legend.maxSizePercent)
                        
                    case .Bottom:
                        legendBottom = min(_legend.neededHeight, _viewPortHandler.chartHeight * _legend.maxSizePercent)
                        
                    default:
                        break;
                    }
                }
            
            case .Horizontal:
                
                var yLegendOffset: CGFloat = 0.0
                
                if _legend.verticalAlignment == .Top
                    || _legend.verticalAlignment == .Bottom
                {
                    // It's possible that we do not need this offset anymore as it
                    //   is available through the extraOffsets, but changing it can mean
                    //   changing default visibility for existing apps.
                    let yOffset = self.requiredLegendOffset
                    
                    yLegendOffset = min(
                        _legend.neededHeight + yOffset,
                        _viewPortHandler.chartHeight * _legend.maxSizePercent)
                }
                
                switch _legend.verticalAlignment
                {
                case .Top:
                    
                    legendTop = yLegendOffset
                    
                case .Bottom:
                    
                    legendBottom = yLegendOffset
                    
                default:
                    break;
                }
            }

            legendLeft += self.requiredBaseOffset
            legendRight += self.requiredBaseOffset
            legendTop += self.requiredBaseOffset
            legendBottom += self.requiredBaseOffset
        }
        
        legendTop += self.extraTopOffset
        legendRight += self.extraRightOffset
        legendBottom += self.extraBottomOffset
        legendLeft += self.extraLeftOffset
        
        var minOffset = self.minOffset
        
        if (self.isKindOfClass(RadarChartView))
        {
            let x = self.xAxis
            
            if x.isEnabled && x.drawLabelsEnabled
            {
                minOffset = max(minOffset, x.labelRotatedWidth)
            }
        }

        let offsetLeft = max(minOffset, legendLeft)
        let offsetTop = max(minOffset, legendTop)
        let offsetRight = max(minOffset, legendRight)
        let offsetBottom = max(minOffset, max(self.requiredBaseOffset, legendBottom))

        _viewPortHandler.restrainViewPort(offsetLeft: offsetLeft, offsetTop: offsetTop, offsetRight: offsetRight, offsetBottom: offsetBottom)
    }

    /// - returns: the angle relative to the chart center for the given point on the chart in degrees.
    /// The angle is always between 0 and 360°, 0° is NORTH, 90° is EAST, ...
    public func angleForPoint(x x: CGFloat, y: CGFloat) -> CGFloat
    {
        let c = centerOffsets
        
        let tx = Double(x - c.x)
        let ty = Double(y - c.y)
        let length = sqrt(tx * tx + ty * ty)
        let r = acos(ty / length)

        var angle = r * ChartUtils.Math.RAD2DEG

        if (x > c.x)
        {
            angle = 360.0 - angle
        }

        // add 90° because chart starts EAST
        angle = angle + 90.0

        // neutralize overflow
        if (angle > 360.0)
        {
            angle = angle - 360.0
        }

        return CGFloat(angle)
    }
    
    /// Calculates the position around a center point, depending on the distance
    /// from the center, and the angle of the position around the center.
    internal func getPosition(center center: CGPoint, dist: CGFloat, angle: CGFloat) -> CGPoint
    {
        return CGPoint(x: center.x + dist * cos(angle * ChartUtils.Math.FDEG2RAD),
                y: center.y + dist * sin(angle * ChartUtils.Math.FDEG2RAD))
    }

    /// - returns: the distance of a certain point on the chart to the center of the chart.
    public func distanceToCenter(x x: CGFloat, y: CGFloat) -> CGFloat
    {
        let c = self.centerOffsets

        var dist = CGFloat(0.0)

        var xDist = CGFloat(0.0)
        var yDist = CGFloat(0.0)

        if (x > c.x)
        {
            xDist = x - c.x
        }
        else
        {
            xDist = c.x - x
        }

        if (y > c.y)
        {
            yDist = y - c.y
        }
        else
        {
            yDist = c.y - y
        }

        // pythagoras
        dist = sqrt(pow(xDist, 2.0) + pow(yDist, 2.0))

        return dist
    }

    /// - returns: the xIndex for the given angle around the center of the chart.
    /// -1 if not found / outofbounds.
    public func indexForAngle(angle: CGFloat) -> Int
    {
        fatalError("indexForAngle() cannot be called on PieRadarChartViewBase")
    }

    /// current rotation angle of the pie chart
    ///
    /// **default**: 270 --> top (NORTH)
    /// - returns: will always return a normalized value, which will be between 0.0 < 360.0
    public var rotationAngle: CGFloat
    {
        get
        {
            return _rotationAngle
        }
        set
        {
            _rawRotationAngle = newValue
            _rotationAngle = ChartUtils.normalizedAngleFromAngle(newValue)
            setNeedsDisplay()
        }
    }
    
    /// gets the raw version of the current rotation angle of the pie chart the returned value could be any value, negative or positive, outside of the 360 degrees. 
    /// this is used when working with rotation direction, mainly by gestures and animations.
    public var rawRotationAngle: CGFloat
    {
        return _rawRotationAngle
    }

    /// - returns: the diameter of the pie- or radar-chart
    public var diameter: CGFloat
    {
        var content = _viewPortHandler.contentRect
        content.origin.x += extraLeftOffset
        content.origin.y += extraTopOffset
        content.size.width -= extraLeftOffset + extraRightOffset
        content.size.height -= extraTopOffset + extraBottomOffset
        return min(content.width, content.height)
    }

    /// - returns: the radius of the chart in pixels.
    public var radius: CGFloat
    {
        fatalError("radius cannot be called on PieRadarChartViewBase")
    }

    /// - returns: the required offset for the chart legend.
    internal var requiredLegendOffset: CGFloat
    {
        fatalError("requiredLegendOffset cannot be called on PieRadarChartViewBase")
    }

    /// - returns: the base offset needed for the chart without calculating the
    /// legend size.
    internal var requiredBaseOffset: CGFloat
    {
        fatalError("requiredBaseOffset cannot be called on PieRadarChartViewBase")
    }
    
    public override var chartYMax: Double
    {
        return 0.0
    }
    
    public override var chartYMin: Double
    {
        return 0.0
    }
    
    /// The SelectionDetail objects give information about the value at the selected index and the DataSet it belongs to.
    /// - returns: an array of SelectionDetail objects for the given x-index.
    public func getSelectionDetailsAtIndex(xIndex: Int) -> [ChartSelectionDetail]
    {
        var vals = [ChartSelectionDetail]()
        
        guard let data = _data else { return vals }

        for i in 0 ..< data.dataSetCount
        {
            guard let dataSet = data.getDataSetByIndex(i) else { continue }
            
            if !dataSet.isHighlightEnabled
            {
                continue
            }
            
            // extract all y-values from all DataSets at the given x-index
            let yVal = dataSet.yValForXIndex(xIndex)
            if (yVal.isNaN)
            {
                continue
            }
            
            vals.append(ChartSelectionDetail(value: yVal, dataSetIndex: i, dataSet: dataSet))
        }
        
        return vals
    }
    
    public var isRotationEnabled: Bool { return rotationEnabled; }
    
    /// flag that indicates if rotation is done with two fingers or one.
    /// when the chart is inside a scrollview, you need a two-finger rotation because a one-finger rotation eats up all touch events.
    ///
    /// On iOS this will disable one-finger rotation.
    /// On OSX this will keep two-finger multitouch rotation, and one-pointer mouse rotation.
    /// 
    /// **default**: false
    public var rotationWithTwoFingers: Bool
    {
        get
        {
            return _rotationWithTwoFingers
        }
        set
        {
            _rotationWithTwoFingers = newValue
            #if !os(tvOS)
                _rotationGestureRecognizer.enabled = _rotationWithTwoFingers
            #endif
        }
    }
    
    /// flag that indicates if rotation is done with two fingers or one.
    /// when the chart is inside a scrollview, you need a two-finger rotation because a one-finger rotation eats up all touch events.
    ///
    /// On iOS this will disable one-finger rotation.
    /// On OSX this will keep two-finger multitouch rotation, and one-pointer mouse rotation.
    ///
    /// **default**: false
    public var isRotationWithTwoFingers: Bool
    {
        return _rotationWithTwoFingers
    }
    
    // MARK: - Animation
    
    private var _spinAnimator: ChartAnimator!
    
    /// Applys a spin animation to the Chart.
    public func spin(duration duration: NSTimeInterval, fromAngle: CGFloat, toAngle: CGFloat, easing: ChartEasingFunctionBlock?)
    {
        if (_spinAnimator != nil)
        {
            _spinAnimator.stop()
        }
        
        _spinAnimator = ChartAnimator()
        _spinAnimator.updateBlock = {
            self.rotationAngle = (toAngle - fromAngle) * self._spinAnimator.phaseX + fromAngle
        }
        _spinAnimator.stopBlock = { self._spinAnimator = nil; }
        
        _spinAnimator.animate(xAxisDuration: duration, easing: easing)
    }
    
    public func spin(duration duration: NSTimeInterval, fromAngle: CGFloat, toAngle: CGFloat, easingOption: ChartEasingOption)
    {
        spin(duration: duration, fromAngle: fromAngle, toAngle: toAngle, easing: easingFunctionFromOption(easingOption))
    }
    
    public func spin(duration duration: NSTimeInterval, fromAngle: CGFloat, toAngle: CGFloat)
    {
        spin(duration: duration, fromAngle: fromAngle, toAngle: toAngle, easing: nil)
    }
    
    public func stopSpinAnimation()
    {
        if (_spinAnimator != nil)
        {
            _spinAnimator.stop()
        }
    }
    
    // MARK: - Gestures
    
    private var _rotationGestureStartPoint: CGPoint!
    private var _isRotating = false
    private var _startAngle = CGFloat(0.0)
    
    private struct AngularVelocitySample
    {
        var time: NSTimeInterval
        var angle: CGFloat
    }
    
    private var _velocitySamples = [AngularVelocitySample]()
    
    private var _decelerationLastTime: NSTimeInterval = 0.0
    private var _decelerationDisplayLink: NSUIDisplayLink!
    private var _decelerationAngularVelocity: CGFloat = 0.0
    
    internal final func processRotationGestureBegan(location location: CGPoint)
    {
        self.resetVelocity()
        
        if rotationEnabled
        {
            self.sampleVelocity(touchLocation: location)
        }
        
        self.setGestureStartAngle(x: location.x, y: location.y)
        
        _rotationGestureStartPoint = location
    }
    
    internal final func processRotationGestureMoved(location location: CGPoint)
    {
        if isDragDecelerationEnabled
        {
            sampleVelocity(touchLocation: location)
        }
        
        if !_isRotating &&
            distance(
                eventX: location.x,
                startX: _rotationGestureStartPoint.x,
                eventY: location.y,
                startY: _rotationGestureStartPoint.y) > CGFloat(8.0)
        {
            _isRotating = true
        }
        else
        {
            self.updateGestureRotation(x: location.x, y: location.y)
            setNeedsDisplay()
        }
    }
    
    internal final func processRotationGestureEnded(location location: CGPoint)
    {
        if isDragDecelerationEnabled
        {
            stopDeceleration()
            
            sampleVelocity(touchLocation: location)
            
            _decelerationAngularVelocity = calculateVelocity()
            
            if _decelerationAngularVelocity != 0.0
            {
                _decelerationLastTime = CACurrentMediaTime()
                _decelerationDisplayLink = NSUIDisplayLink(target: self, selector: #selector(PieRadarChartViewBase.decelerationLoop))
                _decelerationDisplayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            }
        }
    }
    
    internal final func processRotationGestureCancelled()
    {
        if (_isRotating)
        {
            _isRotating = false
        }
    }
    
    #if !os(OSX)
    public override func nsuiTouchesBegan(touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        // if rotation by touch is enabled
        if (rotationEnabled)
        {
            stopDeceleration()
            
            if (!rotationWithTwoFingers)
            {
                let touch = touches.first as NSUITouch!
                
                let touchLocation = touch.locationInView(self)
                
                processRotationGestureBegan(location: touchLocation)
            }
        }
        
        if (!_isRotating)
        {
            super.nsuiTouchesBegan(touches, withEvent: event)
        }
    }
    
    public override func nsuiTouchesMoved(touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        if (rotationEnabled && !rotationWithTwoFingers)
        {
            let touch = touches.first as NSUITouch!
            
            let touchLocation = touch.locationInView(self)
            
            processRotationGestureMoved(location: touchLocation)
        }
        
        if (!_isRotating)
        {
            super.nsuiTouchesMoved(touches, withEvent: event)
        }
    }
    
    public override func nsuiTouchesEnded(touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
        if (!_isRotating)
        {
            super.nsuiTouchesEnded(touches, withEvent: event)
        }
        
        if (rotationEnabled && !rotationWithTwoFingers)
        {
            let touch = touches.first as NSUITouch!
            
            let touchLocation = touch.locationInView(self)
            
            processRotationGestureEnded(location: touchLocation)
        }
        
        if (_isRotating)
        {
            _isRotating = false
        }
    }
    
    public override func nsuiTouchesCancelled(touches: Set<NSUITouch>?, withEvent event: NSUIEvent?)
    {
        super.nsuiTouchesCancelled(touches, withEvent: event)
        
        processRotationGestureCancelled()
    }
    #endif
    
    #if os(OSX)
    public override func mouseDown(theEvent: NSEvent)
    {
        // if rotation by touch is enabled
        if rotationEnabled
        {
            stopDeceleration()
        
            let location = self.convertPoint(theEvent.locationInWindow, fromView: nil)
            
            processRotationGestureBegan(location: location)
        }
        
        if !_isRotating
        {
            super.mouseDown(theEvent)
        }
    }
    
    public override func mouseDragged(theEvent: NSEvent)
    {
        if rotationEnabled
        {
            let location = self.convertPoint(theEvent.locationInWindow, fromView: nil)
            
            processRotationGestureMoved(location: location)
        }
        
        if !_isRotating
        {
            super.mouseDragged(theEvent)
        }
    }
    
    public override func mouseUp(theEvent: NSEvent)
    {
        if !_isRotating
        {
            super.mouseUp(theEvent)
        }
        
        if rotationEnabled
        {
            let location = self.convertPoint(theEvent.locationInWindow, fromView: nil)
            
            processRotationGestureEnded(location: location)
        }
        
        if _isRotating
        {
            _isRotating = false
        }
    }
    #endif
    
    private func resetVelocity()
    {
        _velocitySamples.removeAll(keepCapacity: false)
    }
    
    private func sampleVelocity(touchLocation touchLocation: CGPoint)
    {
        let currentTime = CACurrentMediaTime()
        
        _velocitySamples.append(AngularVelocitySample(time: currentTime, angle: angleForPoint(x: touchLocation.x, y: touchLocation.y)))
        
        // Remove samples older than our sample time - 1 seconds
        var i = 0, count = _velocitySamples.count
        while (i < count - 2)
        {
            if (currentTime - _velocitySamples[i].time > 1.0)
            {
                _velocitySamples.removeAtIndex(0)
                i -= 1
                count -= 1
            }
            else
            {
                break
            }
            
            i += 1
        }
    }
    
    private func calculateVelocity() -> CGFloat
    {
        if (_velocitySamples.isEmpty)
        {
            return 0.0
        }
        
        var firstSample = _velocitySamples[0]
        var lastSample = _velocitySamples[_velocitySamples.count - 1]
        
        // Look for a sample that's closest to the latest sample, but not the same, so we can deduce the direction
        var beforeLastSample = firstSample
        for i in (_velocitySamples.count - 1).stride(through: 0, by: -1)
        {
            beforeLastSample = _velocitySamples[i]
            if (beforeLastSample.angle != lastSample.angle)
            {
                break
            }
        }
        
        // Calculate the sampling time
        var timeDelta = lastSample.time - firstSample.time
        if (timeDelta == 0.0)
        {
            timeDelta = 0.1
        }
        
        // Calculate clockwise/ccw by choosing two values that should be closest to each other,
        // so if the angles are two far from each other we know they are inverted "for sure"
        var clockwise = lastSample.angle >= beforeLastSample.angle
        if (abs(lastSample.angle - beforeLastSample.angle) > 270.0)
        {
            clockwise = !clockwise
        }
        
        // Now if the "gesture" is over a too big of an angle - then we know the angles are inverted, and we need to move them closer to each other from both sides of the 360.0 wrapping point
        if (lastSample.angle - firstSample.angle > 180.0)
        {
            firstSample.angle += 360.0
        }
        else if (firstSample.angle - lastSample.angle > 180.0)
        {
            lastSample.angle += 360.0
        }
        
        // The velocity
        var velocity = abs((lastSample.angle - firstSample.angle) / CGFloat(timeDelta))
        
        // Direction?
        if (!clockwise)
        {
            velocity = -velocity
        }
        
        return velocity
    }
    
    /// sets the starting angle of the rotation, this is only used by the touch listener, x and y is the touch position
    private func setGestureStartAngle(x x: CGFloat, y: CGFloat)
    {
        _startAngle = angleForPoint(x: x, y: y)
        
        // take the current angle into consideration when starting a new drag
        _startAngle -= _rotationAngle
    }
    
    /// updates the view rotation depending on the given touch position, also takes the starting angle into consideration
    private func updateGestureRotation(x x: CGFloat, y: CGFloat)
    {
        self.rotationAngle = angleForPoint(x: x, y: y) - _startAngle
    }
    
    public func stopDeceleration()
    {
        if (_decelerationDisplayLink !== nil)
        {
            _decelerationDisplayLink.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            _decelerationDisplayLink = nil
        }
    }
    
    @objc private func decelerationLoop()
    {
        let currentTime = CACurrentMediaTime()
        
        _decelerationAngularVelocity *= self.dragDecelerationFrictionCoef
        
        let timeInterval = CGFloat(currentTime - _decelerationLastTime)
        
        self.rotationAngle += _decelerationAngularVelocity * timeInterval
        
        _decelerationLastTime = currentTime
        
        if(abs(_decelerationAngularVelocity) < 0.001)
        {
            stopDeceleration()
        }
    }
    
    /// - returns: the distance between two points
    private func distance(eventX eventX: CGFloat, startX: CGFloat, eventY: CGFloat, startY: CGFloat) -> CGFloat
    {
        let dx = eventX - startX
        let dy = eventY - startY
        return sqrt(dx * dx + dy * dy)
    }
    
    /// - returns: the distance between two points
    private func distance(from from: CGPoint, to: CGPoint) -> CGFloat
    {
        let dx = from.x - to.x
        let dy = from.y - to.y
        return sqrt(dx * dx + dy * dy)
    }
    
    /// reference to the last highlighted object
    private var _lastHighlight: ChartHighlight!
    
    @objc private func tapGestureRecognized(recognizer: NSUITapGestureRecognizer)
    {
        if (recognizer.state == NSUIGestureRecognizerState.Ended)
        {
            if !self.isHighLightPerTapEnabled { return }
            
            let location = recognizer.locationInView(self)
            let distance = distanceToCenter(x: location.x, y: location.y)
            
            // check if a slice was touched
            if (distance > self.radius)
            {
                // if no slice was touched, highlight nothing
                self.highlightValues(nil)
                articleLabel.text = ""
                if _lastHighlight == nil
                {
                    self.highlightValues(nil) // do not call delegate
                }
                else
                {
                    self.highlightValue(highlight: nil, callDelegate: true) // call delegate
                }
                
                _lastHighlight = nil
            }
            else
            {
                var angle = angleForPoint(x: location.x, y: location.y)
                
                if (self.isKindOfClass(PieChartView))
                {
                    angle /= _animator.phaseY
                }
                
                let index = indexForAngle(angle)

                // check if the index could be found
                if (index < 0)
                {
                    self.highlightValues(nil)
                    _lastHighlight = nil
                    articleLabel.text = ""
                }
                else
                {
                    let valsAtIndex = getSelectionDetailsAtIndex(index)
                    
                    var dataSetIndex = 0
                    
                    // get the dataset that is closest to the selection (PieChart only has one DataSet)
                    if (self.isKindOfClass(RadarChartView))
                    {
                        dataSetIndex = ChartUtils.closestDataSetIndexByValue(valsAtIndex: valsAtIndex, value: Double(distance / (self as! RadarChartView).factor), axis: nil) ?? -1
                    }
                    
                    if (dataSetIndex < 0)
                    {
                        self.highlightValues(nil)
                        _lastHighlight = nil
                    }
                    else
                    {
                        let h = ChartHighlight(xIndex: index, dataSetIndex: dataSetIndex)
                        //TODO STYLE THIS LABEL
                        articleLabel.frame = CGRectMake(bounds.minX, bounds.minY, bounds.maxX, bounds.maxY)
                        articleLabel.center = CGPointMake(bounds.midX, bounds.minY + 40)
                        articleLabel.textAlignment = NSTextAlignment.Center
                        articleLabel.font = UIFont(name: "Helvetica", size: CGFloat(20.0))
                        articleLabel.textColor = UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
                        let numArticlesRead = Int((data?.dataSets[0].yValForXIndex(index))!)
                        var articleString = " Articles Read"
                        if (numArticlesRead == 1)
                        {
                            articleString = " Article Read"
                        }
                        articleLabel.text = String(numArticlesRead) + " " + data!.xVals[index]! + articleString
                        self.addSubview(articleLabel)
                        
                        if (_lastHighlight !== nil && h == _lastHighlight)
                        {
                            self.highlightValue(highlight: nil, callDelegate: true)
                            _lastHighlight = nil
                        }
                        else
                        {
                            self.highlightValue(highlight: h, callDelegate: true)
                            _lastHighlight = h
                        }
                    }
                }
            }
        }
    }
    
    #if !os(tvOS)
    @objc private func rotationGestureRecognized(recognizer: NSUIRotationGestureRecognizer)
    {
        if (recognizer.state == NSUIGestureRecognizerState.Began)
        {
            stopDeceleration()
            
            _startAngle = self.rawRotationAngle
        }
        
        if (recognizer.state == NSUIGestureRecognizerState.Began || recognizer.state == NSUIGestureRecognizerState.Changed)
        {
            let angle = ChartUtils.Math.FRAD2DEG * recognizer.nsuiRotation
            
            self.rotationAngle = _startAngle + angle
            setNeedsDisplay()
        }
        else if (recognizer.state == NSUIGestureRecognizerState.Ended)
        {
            let angle = ChartUtils.Math.FRAD2DEG * recognizer.nsuiRotation
            
            self.rotationAngle = _startAngle + angle
            setNeedsDisplay()
            
            if (isDragDecelerationEnabled)
            {
                stopDeceleration()
                
                _decelerationAngularVelocity = ChartUtils.Math.FRAD2DEG * recognizer.velocity
                
                if (_decelerationAngularVelocity != 0.0)
                {
                    _decelerationLastTime = CACurrentMediaTime()
                    _decelerationDisplayLink = NSUIDisplayLink(target: self, selector: #selector(PieRadarChartViewBase.decelerationLoop))
                    _decelerationDisplayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
                }
            }
        }
    }
    #endif
}