//
//  HomeViewController.swift
//  BitWatch
//
//  Created by Matthew Wagner on 1/10/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit
import BitWatchKit

var height: CGFloat = CGFloat();
var width: CGFloat = CGFloat();
var mainView: UIScrollView = UIScrollView();
var homeView: UIView = UIView();
var beginButton: UIButton = UIButton();
var countDownLabel: UILabel = UILabel();
var countDownTimer: NSTimer = NSTimer();
var countDown = 0;

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create the Main Scroll View View
        height = self.view.frame.size.height;
        width = self.view.frame.size.width;
        
        countDown = 10;
        
        mainView = UIScrollView(frame: CGRectMake(0, 0, width, height));
        mainView.contentSize = CGSizeMake((width * 2.0) - 45.0, height);
        mainView.scrollEnabled = false;
        mainView.pagingEnabled = false;
        mainView.backgroundColor = UIColor.whiteColor();
        
        // Create the Home View
        self.buildHomeView();
        
        // Add the Swipe Gesture Recognizer, Oddly you have to have a different recognizer for each direction.
        var swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action:"viewWasSwiped:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        mainView.addGestureRecognizer(swipeRight);
        
        var swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "viewWasSwiped:");
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        mainView.addGestureRecognizer(swipeLeft);
        
        // Create the Settings View
        self.buildSettingsView();
        
        self.view = mainView;
    }
    
    
    // *********************************
    // Build Home View
    // *********************************
    
    func buildHomeView(){
        // Create the Home View
        homeView = UIView(frame: CGRectMake(0, 0, width, height));
        
        // Create the "Begin" button
        beginButton = UIButton(frame: CGRectMake(0, (height * 0.1), width, (height * 0.75)));
        beginButton.alpha = 1.0;
        beginButton.setTitle("begin", forState:UIControlState.Normal);
        beginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        beginButton.titleLabel!.font = UIFont(name: "Montserrat-Bold.ttf", size: 36);
        beginButton.addTarget(self, action: "beginCountdown", forControlEvents: UIControlEvents.TouchUpInside);
        
        // Create the "Menu" button
        var menuButton: UIButton = UIButton(frame: CGRectMake(width - 35, 10, 25, 25));
        var menuImage: UIImage! = UIImage(named: "menu-icon");
        menuButton.setBackgroundImage(menuImage, forState: UIControlState.Normal);
        
        homeView.addSubview(beginButton);
        homeView.addSubview(menuButton);
        mainView.addSubview(homeView);
    }
    
    
    // *********************************
    // Build Settings View
    // *********************************
    
    func buildSettingsView(){
        // Create the Settings View
        let settingsWidth = width - 45;
        var settingsView: UIView = UIView(frame: CGRectMake(width, 0, settingsWidth, height));
        
        // Create the Work Setting Text Field
        var workLabel: UILabel = UILabel(frame: CGRectMake(20, (height * 0.15) - 30, settingsWidth - 40, 50));
            workLabel.font = UIFont(name: "Montserrat-Bold", size: 36);
            workLabel.text = "Work";
        var workSetting: UITextField = UITextField(frame: CGRectMake(20, height * 0.15, settingsWidth - 40, 50));
            workSetting.font = UIFont(name: "Montserrat-Bold", size: 36);
            workSetting.text = "99:99";
        
        settingsView.addSubview(workLabel);
        settingsView.addSubview(workSetting);
        
        // Create the Rest Setting Text Field
        var restLabel: UILabel = UILabel(frame: CGRectMake(20, (height * 0.5) - 30, settingsWidth - 40, 50));
            restLabel.font = UIFont(name: "Montserrat-Bold", size: 36);
            restLabel.text = "Rest";
        var restSetting: UITextField = UITextField(frame: CGRectMake(20, height * 0.5, settingsWidth - 40, 50));
            restSetting.font = UIFont(name: "Montserrat-Bold", size: 36);
            restSetting.text = "99:99";
        
        settingsView.addSubview(restLabel);
        settingsView.addSubview(restSetting);
        
        mainView.addSubview(settingsView);
    }
    
    
    // *********************************
    // Handle the Initial Countdown
    // *********************************
    
    func beginCountdown() {
        // Hide the Begin Button
        beginButton.alpha = 0.0;
        
        // Setup the Countdown Label
        countDownLabel = UILabel(frame: CGRectMake(0, (height * 0.1), width, (height * 0.75)));
        countDownLabel.text = String(countDown);
        countDownLabel.textAlignment = NSTextAlignment.Center;
        countDownLabel.font = UIFont(name: "Montserrat-Bold.ttf", size: 36);
        homeView.addSubview(countDownLabel);
        
        // Start the Countdown
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)
    }
    
    func updateCountdown() {
        // If we're not at 0, update it with the appropriate number
        if( countDown - 1 > 0 ){
            countDown--;
            countDownLabel.text = String(countDown);
        }
        
        // if we are at 0, reset the countdown, update the label and stop the countdown timer.
        else if( countDown - 1 == 0 ){
            countDown = 10;
            countDownLabel.text = "Go!";
            countDownTimer.invalidate();
            self.startWorking();
        }
    }
    
    // *********************************
    // Start Work/Rest Timer
    // *********************************
    
    func startWorking(){
        print("Working");
    }
    
    // ***********************************
    // Handle a swipe on the UIScrollView
    // ***********************************
    
    func viewWasSwiped(gesture: UIGestureRecognizer){
        self.view.endEditing(true);
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if( swipeGesture.direction == UISwipeGestureRecognizerDirection.Right){
                mainView.setContentOffset(CGPointMake(0, 0), animated: true);
            } else if( swipeGesture.direction == UISwipeGestureRecognizerDirection.Left ){
                mainView.setContentOffset(CGPointMake(width - 45, 0), animated: true);
            }
        }
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
