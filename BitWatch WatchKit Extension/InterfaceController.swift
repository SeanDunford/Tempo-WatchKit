//
//  InterfaceController.swift
//  BitWatch WatchKit Extension
//
//  Created by Sean Dunford on 12/4/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var GoButton: WKInterfaceButton!
    @IBOutlet weak var WorkTimer: WKInterfaceTimer!
    @IBOutlet weak var RestTimer: WKInterfaceTimer!

    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        // Configure interface objects here.
        NSLog("%@ init", self)
        initTimers()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }
    func initTimers(){
        var d: NSDate = NSDate()
        var wsecs: NSTimeInterval = 901
        var rsecs: NSTimeInterval = 301
        var wd = d.dateByAddingTimeInterval(wsecs)
        var rd = d.dateByAddingTimeInterval(rsecs)
        
        WorkTimer.setDate(wd)
        RestTimer.setDate(rd)
        WorkTimer.start()
        RestTimer.start()
        WorkTimer.stop()
        RestTimer.stop()
    }
    @IBAction func GoButtonPressed() {
        initTimers()
        WorkTimer.start()
        RestTimer.start()
        
        startWorkTimer()
        startRestTimer()
    }
    func startWorkTimer(){
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("workUpdate"), userInfo: nil, repeats: true)
    }
    func startRestTimer(){
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("restUpdate"), userInfo: nil, repeats: true)
    }
    func workUpdate() {
        println("workUpdate")
    }
    func restUpdate() {
        println("restUpdate")
    }
}
