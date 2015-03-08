

import Foundation
import UIKit
import TempoSharedFramework

public class RestView: UIView{
    var height: CGFloat!
    var width: CGFloat!
    var restTime: UILabel!
    var intervalLabel: UILabel!
    var timerObj: TimerModel!{
        willSet(x){
            restTime.text = String(x.getRestSeconds());
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        height = frame.size.height
        width = frame.size.width
        initialize()
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initialize(){
        var restLabel: UILabel = UILabel(frame: CGRectMake(0, (height * 0.4) - 30, width, 50));
        restLabel.text = "Rest";
        restLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        restLabel.textColor = UIColor().restRed();
        restLabel.textAlignment = NSTextAlignment.Center;
    
        restTime = UILabel(frame: CGRectMake(0, (height * 0.4), width, 125));
        restTime.text = "99:99";
        restTime.font = UIFont(name: "Montserrat-Bold", size: 100);
        restTime.textColor = UIColor().restRed();
        restTime.textAlignment = NSTextAlignment.Center;
        
        intervalLabel = UILabel(frame: CGRectMake(0, (height * 0.7) - 30, width, 50));
        // We should make this the current interval number out of total intervals..
        // For example: 2/8
        intervalLabel.text = "0/0";
        intervalLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        intervalLabel.textColor = UIColor().intervalGreen();
        intervalLabel.textAlignment = NSTextAlignment.Center;

        let settingsWidth = width - 45;
        var settingsView: UIView = UIView(frame: CGRectMake(width, 0, settingsWidth, height));
        settingsView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02);
        
        self.addSubview(restLabel)
        self.addSubview(restTime)
        self.addSubview(intervalLabel);
    }
    func updateTime(secs: Int){
        var m = (secs / 60) % 60;
        var s = secs % 60;
        
        var formattedTime: NSString = String(format: "%02u:%02u", m, s);
        restTime.text = formattedTime as? String
    }
    
    func updateInterval(current: Int, total: Int){
        intervalLabel.text = "\(current)/\(total)";
    }
    
    func startTimer(){
        updateTime(Int(timerObj.getRestSeconds()))
    }
    func stopTimer(){
        
    }

}