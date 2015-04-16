//
//  GlanceController.swift
//  TempoWatch WatchKit Extension
//
//  Created by Sean Dunford on 2/7/15.
//  Copyright (c) 2015 GetGainz. All rights reserved.
//

import WatchKit
import Foundation
import TempoSharedFramework


class GlanceController: WKInterfaceController {
    var timerObj: TimerModel = TimerModel()
    
    @IBOutlet weak var glanceTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var glanceInfoLabel: WKInterfaceLabel!
 
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        timerObj.update()
        updateView()
    }
    
    func updateView(){
        var str = ""
        var color = UIColor.whiteColor()
        switch timerObj.state{
            case .pause:
                str = "Paused"
                color = UIColor(red: (208.0/255.0), green: (93.0/255.0), blue: (93.0/255.0), alpha: 1.0)
        case .work:
                str = "Working"
                color = UIColor(red: (178.0/255.0), green: (124.0/255.0), blue: (209.0/255.0), alpha: 1.0)
            case .rest:
                str = "Resting"
                color = UIColor(red:(124.0/255.0), green:(208.0/255.0), blue:(126.0/255.0), alpha: 1.0)
        }
        
        glanceInfoLabel.setText(str)
        glanceInfoLabel.setTextColor(color)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
