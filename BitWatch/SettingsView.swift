//
//  SettingsView.swift
//  BitWatch
//
//  Created by Sean Dunford on 1/17/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit


public class SettingsView: UIView{
    var width: CGFloat!
    var height: CGFloat!
    
    // Text Fields
    var workSetting: UITextField!
    var restSetting: UITextField!
    var intervalSetting: UITextField!
    
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
        
            var workLabel: UILabel = UILabel(frame: CGRectMake(20, (self.frame.size.height * 0.15) - 30, settingsWidth - 40, 50));
            workLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
            workLabel.textColor = UIColor().workPurple();
            workLabel.text = "Work";
            workSetting = UITextField(frame: CGRectMake(20, self.frame.size.height * 0.15, settingsWidth - 40, 50));
            workSetting.font = UIFont(name: "Montserrat-Bold", size: 48);
            workSetting.textColor = UIColor().workPurple();
            workSetting.text = "99:99";
            
            self.addSubview(workLabel);
            self.addSubview(workSetting);
            
            // Create the Rest Setting Text Field
            var restLabel: UILabel = UILabel(frame: CGRectMake(20, (self.frame.size.height * 0.5) - 30, settingsWidth - 40, 50));
            restLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
            restLabel.textColor = UIColor().restRed();
            restLabel.text = "Rest";
            restSetting = UITextField(frame: CGRectMake(20, self.frame.size.height * 0.5, settingsWidth - 40, 50));
            restSetting.font = UIFont(name: "Montserrat-Bold", size: 48);
            restSetting.textColor = UIColor().restRed();
            restSetting.text = "99:99";
            
            self.addSubview(restLabel);
            self.addSubview(restSetting);
            
            // Create the Interval Setting Text Field
            var intervalLabel: UILabel = UILabel(frame: CGRectMake(20, (self.frame.size.height * 0.8) - 30, settingsWidth - 40, 50));
            intervalLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
            intervalLabel.textColor = UIColor().intervalGreen();
            intervalLabel.text = "Intervals";
            intervalSetting = UITextField(frame: CGRectMake(20, self.frame.size.height * 0.8, settingsWidth - 40, 50));
            intervalSetting.font = UIFont(name: "Montserrat-Bold", size: 48);
            intervalSetting.textColor = UIColor().intervalGreen();
            intervalSetting.text = "9999";
            
            self.addSubview(intervalLabel);
            self.addSubview(intervalSetting);
            
    }
}