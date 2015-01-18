//
//  HomeViewController.swift
//  BitWatch
//
//  Created by Matthew Wagner on 1/10/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit
import BitWatchKit
import iAd

class HomeViewController: UIViewController, ADBannerViewDelegate, SettingsViewDelegate {
    enum HomeViewControllerState: Int{
        case home = 0
        case work = 1
        case rest = 2
        case settings = 3
    }
    var state: HomeViewControllerState = .home
    
    var adBannerView: ADBannerView!
    
    var countDownLabel: UILabel!
    var countDownTimer: NSTimer!
    var countDown = 0;
    
    //Main Views
    var containerView: ContainerView!
    var homeView: HomeView!
    var workView: WorkView!
    var restView: RestView!
    var settingsView: SettingsView!
    
    //Sizes
    var height: CGFloat!
    var width: CGFloat!
    
    // Colors
    var intervalGreen: UIColor = UIColor().intervalGreen()
    var workPurple: UIColor = UIColor().workPurple()
    var restRed: UIColor = UIColor().restRed()

    func setupIAds(){
        self.canDisplayBannerAds = true;
        self.adBannerView = ADBannerView(frame: CGRectMake(0, height - 50, width, 50));
        self.adBannerView.delegate = self;
        self.adBannerView.hidden = true;
    }
    override init() {
        super.init()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        height = self.view.frame.size.height;
        width = self.view.frame.size.width;
        
        setupIAds()
 
        var f: CGRect = CGRectMake(0, 0, width, height - 50)
        containerView = ContainerView(frame: f)
        
        f = CGRectMake(0, 0, width, height)
        homeView = HomeView(frame: f)
        restView = RestView(frame: f)
        workView = WorkView(frame: f)
        
        f = CGRectMake(width, 0, width, height)
        settingsView = SettingsView(frame:f)
        settingsView.delegate = self;
        
        setState(.home)
        self.view.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(containerView);
        containerView.addSubview(settingsView)
        
        countDown = 3
        setupViews()
    }
    func setupViews(){
        homeView.countDown = countDown
        homeView.beginBlock = beginCountdown
        
        addMenuButtonToView(homeView)
        addMenuButtonToView(workView)
        addMenuButtonToView(restView)
        
    }
    func setState(state:HomeViewControllerState){
        switch(state){
        case .home:
            setHomeView()
        case .rest:
            setRestView()
        case .work:
            setWorkView()
        case .settings:
            setSettingsView()
        default:
            println("state is " + String(state.rawValue))
        }
        self.state = state
    }
    func setHomeView(){
        homeView.removeFromSuperview()
        workView.removeFromSuperview()
        restView.removeFromSuperview()
        containerView.addSubview(homeView)
    }
    func setRestView(){
        homeView.removeFromSuperview()
        workView.removeFromSuperview()
        restView.removeFromSuperview()
        containerView.addSubview(restView)
    }
    func setWorkView(){
        homeView.removeFromSuperview()
        workView.removeFromSuperview()
        restView.removeFromSuperview()
        containerView.addSubview(workView)
    }
    func setSettingsView(){
        homeView.removeFromSuperview()
        workView.removeFromSuperview()
        restView.removeFromSuperview()
        containerView.addSubview(settingsView)
    }
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        println("Banner Will Load Ad");
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        println("Banner did load Ad");
        self.adBannerView.hidden = false;
    }
    
    func beginCountdown() {
        homeView.startTimer()
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)
    }
    
    func updateCountdown() {
        println(countDown)
        // If we're not at 0, update it with the appropriate number
        if( countDown - 1 > 0 ){
            countDown--;
            homeView.countDownLabel.text = String(countDown);
        }
        
        // if we are at 0, reset the countdown, update the label and stop the countdown timer.
        else if( countDown - 1 == 0 ){
            homeView.countDown = 10;
            homeView.countDownLabel.text = "Go!";
            countDownTimer.invalidate();
            setState(HomeViewControllerState.work)
            homeView.stopTimer()
        }
    }
    
    func scrollToPoint(point: CGPoint) {
        containerView.scrollView.setContentOffset(point, animated: true);
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
    func addMenuButtonToView(view: UIView){
        var menuButton: UIButton = UIButton(frame: CGRectMake(width - 35, 10, 25, 25));
        var menuImage: UIImage! = UIImage(named: "menu-icon");
        menuButton.setBackgroundImage(menuImage, forState: UIControlState.Normal);
        menuButton.addTarget(self, action: "menuClicked", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(menuButton);
    }
    func menuClicked(){
        containerView.toggleMenuOpen()
        dismissKeyBoard()
    }
    func dismissKeyBoard(){
        settingsView.workSetting.resignFirstResponder()
        settingsView.restSetting.resignFirstResponder()
        settingsView.intervalSetting.resignFirstResponder()
    }

}
