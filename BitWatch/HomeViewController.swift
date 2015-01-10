//
//  HomeViewController.swift
//  BitWatch
//
//  Created by Matthew Wagner on 1/10/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit
import BitWatchKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let height = self.view.frame.size.height;
        let width = self.view.frame.size.width;
        
        // Create the Home View
        var homeView: UIView = UIView(frame: CGRectMake(0, (height / 2), width, 50));
        homeView.backgroundColor = UIColor.whiteColor();
        
        // Create the "Begin" button
        var beginButton: UIButton = UIButton(frame: CGRectMake(0, (height * 0.25), width, (height * 0.75)));
            beginButton.setTitle("begin", forState:UIControlState.Normal);
        
        // Create the "Menu" button
        var menuButton: UIButton = UIButton(frame: CGRectMake(width - 60, 10, 50, 50));
        var menuImage: UIImage! = UIImage(named: "menu-icon");
            menuButton.setBackgroundImage(menuImage, forState: UIControlState.Normal);
        
         homeView.addSubview(beginButton);
         homeView.addSubview(menuButton);
        self.view.addSubview(homeView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func foo(){
        var timer: TimerModel! = TimerModel()
        var defaults: NSUserDefaults
        var group = "group.alphastory.bitwatch"
        defaults = NSUserDefaults(suiteName: group)!
        defaults.setObject(timer, forKey:"timer")
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
