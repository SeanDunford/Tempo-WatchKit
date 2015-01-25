//
//  SettingsView.swift
//  BitWatch
//
//  Created by Sean Dunford on 1/17/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewDelegate {
    func scrollToPoint(point: CGPoint);
    func enableScroll(enable: Bool)
}

public class SettingsView: UIView, UITextFieldDelegate{
    var width: CGFloat!
    var height: CGFloat!
    var mode: Int!
    
    var intervalAmount: Int!{
        willSet(i){
            intervalSetting.text = String(i)
        }
    }
    
    var restCountDown: Int!{
        willSet(i){
            var m = (i / 60) % 60;
            var s = i % 60;
            
            var formattedTime: NSString = String(format: "%02u:%02u", m, s);
            restSetting.text = formattedTime
        }
    }
    
    var workCountDown: Int!{
        willSet(i){
            var m = (i / 60) % 60;
            var s = i % 60;
            
            var formattedTime: NSString = String(format: "%02u:%02u", m, s);
            workSetting.text = formattedTime
        }
    }
    
    // Labels
    var workSetting: UILabel!
    var restSetting: UILabel!
    var intervalSetting: UILabel!
    var workLabel: UILabel!
    var restLabel: UILabel!
    var intervalLabel: UILabel!
    
    //Invisible Buttons
    var workBtn: UIButton!
    var restBtn: UIButton!
    var intervalBtn: UIButton!
    
    var xBtn: UIButton!
    
    var circleView: BWCircularSlider!
    
    var delegate: SettingsViewDelegate!
    
    override init(frame:CGRect){
        super.init(frame:frame)
        width = frame.size.width
        height = frame.size.height
        initialize()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func initialize(){
        let settingsWidth = width - 45;
    
        mode = 0
        
        workLabel = UILabel(frame: CGRectMake(20, (self.frame.size.height * 0.15) - 30, settingsWidth - 40, 50));
        workLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        workLabel.textColor = UIColor().workPurple();
        workLabel.text = "Work";
        workSetting = UILabel(frame: CGRectMake(20, self.frame.size.height * 0.15, settingsWidth - 40, 50));
        workSetting.font = UIFont(name: "Montserrat-Bold", size: 48);
        workSetting.textColor = UIColor().workPurple();
        workSetting.tag = 0
        workBtn = UIButton(frame: CGRectMake(20, (self.frame.size.height * 0.15) - 30, settingsWidth, 100))
        workBtn.backgroundColor = UIColor.clearColor()
        workBtn.addTarget(self, action: "btnPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        workBtn.tag = 0
        
        self.addSubview(workLabel);
        self.addSubview(workSetting);
        self.addSubview(workBtn)
        
        // Create the Rest Setting Text Field
        restLabel = UILabel(frame: CGRectMake(20, (self.frame.size.height * 0.45) - 30, settingsWidth - 40, 50));
        restLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        restLabel.textColor = UIColor().restRed();
        restLabel.text = "Rest";
        restSetting = UILabel(frame: CGRectMake(20, self.frame.size.height * 0.45, settingsWidth - 40, 50));
        restSetting.font = UIFont(name: "Montserrat-Bold", size: 48);
        restSetting.textColor = UIColor().restRed();
        restSetting.tag = 1;
        restBtn = UIButton(frame: CGRectMake(20, (self.frame.size.height * 0.45) - 30, settingsWidth, 100))
        restBtn.backgroundColor = UIColor.clearColor()
        restBtn.addTarget(self, action: "btnPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        restBtn.tag = 1
        
        self.addSubview(restLabel);
        self.addSubview(restSetting);
        self.addSubview(restBtn)
        
        // Create the Interval Setting Text Field
        intervalLabel = UILabel(frame: CGRectMake(20, (self.frame.size.height * 0.75) - 30, settingsWidth - 40, 50));
        intervalLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        intervalLabel.textColor = UIColor().intervalGreen();
        intervalLabel.text = "Intervals";
        intervalSetting = UILabel(frame: CGRectMake(20, self.frame.size.height * 0.75, settingsWidth - 40, 50));
        intervalSetting.font = UIFont(name: "Montserrat-Bold", size: 48);
        intervalSetting.textColor = UIColor().intervalGreen();
        intervalSetting.tag = 2;
        intervalBtn = UIButton(frame: CGRectMake(20, (self.frame.size.height * 0.75) - 30, settingsWidth, 100))
        intervalBtn.backgroundColor = UIColor.clearColor()
        intervalBtn.addTarget(self, action: "btnPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        intervalBtn.backgroundColor = UIColor.clearColor()
        intervalBtn.tag = 2
        
        self.addSubview(intervalLabel);
        self.addSubview(intervalSetting);
        self.addSubview(intervalBtn)
        
        var frame = CGRectMake(-(45/2), (self.height - self.width)/2, self.width, self.width)
        var color = UIColor().workPurple()
        
        circleView = BWCircularSlider(textColor:color, startColor:color, endColor:color, frame: frame)
        circleView.alpha = 0
        self.addSubview(circleView)
        
        var xImg =  UIImage(named:"xBtn")
        var size = xImg?.size
        
        xBtn = UIButton(frame: CGRectMake(width - 30 - 5, 10, 25, 25))
        xBtn.setBackgroundImage(xImg, forState: UIControlState.Normal)
        xBtn.alpha = 0
        xBtn.addTarget(self, action: "xBtnPressed", forControlEvents: UIControlEvents.TouchUpInside)
        xBtn.backgroundColor = UIColor.clearColor()
        xBtn.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(xBtn)
        
    }
    func xBtnPressed(){
        var val = circleView.currValue
        switch(mode){
        case 0:
            workCountDown = Int(val)
        case 1:
            restCountDown = Int(val)
        case 2:
            intervalAmount = Int(val)
        default:
            return;
        }
        fadeSettingsViews(true)
        mode = 0
        self.delegate.enableScroll(true)
    }
    func btnPressed(btn: UIButton){
        var tag: Int = btn.tag
        var color: UIColor
        var maxValue: CGFloat
        var timeMode: Bool
        var currValue: CGFloat
        if(tag == 0){ //Work
            color = UIColor().workPurple()
            maxValue = 3600
            timeMode = true
            currValue = CGFloat(workCountDown)
        } else if(tag == 1){ //Rest
            color = UIColor().restRed()
            maxValue = 3600
            timeMode = true
            currValue = CGFloat(restCountDown)
        }
        else{ // Interval
            color = UIColor().intervalGreen()
            maxValue = 10
            timeMode = false
            currValue = CGFloat(intervalAmount)
        }
        mode = tag
        self.delegate.enableScroll(false)
        circleView.updateView(color,
            beginColor: color,
            endColor: color,
            maxValue: maxValue,
            currValue: currValue,
            timeMode:timeMode)
        
        fadeSettingsViews(false)
        
    }
    public func fadeSettingsViews(fadeIn: Bool){
        UIView.animateWithDuration(0.4, animations: {
            
                //If fadeIn make visible else make clear
                var alpha: CGFloat = (fadeIn) ? 1.0 : 0.0
                self.restLabel.alpha = alpha
                self.workLabel.alpha = alpha
                self.workSetting.alpha = alpha
                self.restLabel.alpha = alpha
                self.restSetting.alpha = alpha
                self.intervalLabel.alpha = alpha
                self.intervalSetting.alpha = alpha
            
                //Flip alpha value
                alpha = (alpha == 1.0) ? 0.0 : 1.0
                self.circleView.alpha = alpha
                self.xBtn.alpha = alpha
            }, completion: {
                (value: Bool) in
                
        })
        
    }
    public func textFieldDidBeginEditing(textField: UITextField) {
        if( textField.tag == 0 ){
            // Work Setting Text Field
            delegate.scrollToPoint(CGPointMake(width, (self.frame.size.height * 0.15) - 60));
        } else if( textField.tag == 1){
            // Rest Setting Text Field
            delegate.scrollToPoint(CGPointMake(width, (self.frame.size.height * 0.5) - 60));
        } else if( textField.tag == 2){
            // Interval Setting Text Field
            delegate.scrollToPoint(CGPointMake(width, (self.frame.size.height * 0.8) - 60));
        }
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        delegate.scrollToPoint(CGPointMake(width, 0));
    }
    
}