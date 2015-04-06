//
//  GoogleAnalytics.swift
//  TempoWatch
//
//  Created by Matthew Wagner on 4/5/15.
//  Copyright (c) 2015 GetGainz. All rights reserved.
//

import Foundation
import UIKit
import TempoSharedFramework

extension UIViewController {
    
    func setScreeName(name: String) {
        self.title = name
        self.sendScreenView()
    }
    
    func sendScreenView() {
        var tracker = GAI.sharedInstance().defaultTracker;
//        tracker.set(kGAIScreenName, value: self.title)
//        tracker.send(GAIDictionaryBuilder.createScreenView().build())
    }
}
