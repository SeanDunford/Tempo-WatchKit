
import Foundation
import UIKit
import TempoSharedFramework

public class WorkView: UIView{
    var height: CGFloat!
    var width: CGFloat!
    var workTime: UILabel!
    var intervalLabel: UILabel!
    var pauseGesture: UITapGestureRecognizer!
    var pauseCb: (() -> ())?
    var timerObj: TimerModel!{
        willSet(x){
            workTime.text = String(x.getWorkSeconds());
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        height = frame.size.height
        width = frame.size.width
        pauseGesture = UITapGestureRecognizer(target: self, action: Selector("didTap"))
        self.addGestureRecognizer(pauseGesture)
        pauseGesture.cancelsTouchesInView = false
        initialize()
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initialize(){
        var workLabel: UILabel = UILabel(frame: CGRectMake(0, (height * 0.4) - 30, width, 50));
        workLabel.text = "Work";
        workLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        workLabel.textColor = UIColor().workPurple();
        workLabel.textAlignment = NSTextAlignment.Center;
        
        workTime = UILabel(frame: CGRectMake(0, (height * 0.4), width, 125));
        workTime.font = UIFont(name: "Montserrat-Bold", size: 100);
        workTime.textColor = UIColor().workPurple();
        workTime.textAlignment = NSTextAlignment.Center;
        
        intervalLabel = UILabel(frame: CGRectMake(0, (height * 0.7) - 30, width, 50));
        // We should make this the current interval number out of total intervals..
        // For example: 2/8
        intervalLabel.text = "0/0";
        intervalLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        intervalLabel.textColor = UIColor().intervalGreen();
        intervalLabel.textAlignment = NSTextAlignment.Center;
        
        self.addSubview(workLabel);
        self.addSubview(workTime);
        self.addSubview(intervalLabel);
    }
    func didTap(){
        pauseCb?()
    }
    func updateTime(secs: Int){
        var m = (secs / 60) % 60;
        var s = secs % 60;
        
        var formattedTime: NSString = String(format: "%02u:%02u", m, s);
        workTime.text = formattedTime as String
    }
    
    func updateInterval(current: Int, total: Int){
        intervalLabel.text = "\(current)/\(total)";
    }
    
    func startTimer(){
        updateTime(Int(timerObj.getWorkSeconds()))
    }
    
    func stopTimer(){
        
    }
}