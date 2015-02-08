
import Foundation
import UIKit
import TempoSharedFramework

public class WorkView: UIView{
    var height: CGFloat!
    var width: CGFloat!
    var workTime: UILabel!
    var timerObj: TimerModel!{
        willSet(x){
            workTime.text = String(x.getWorkSeconds());
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
        var workLabel: UILabel = UILabel(frame: CGRectMake(0, (height * 0.4) - 30, width, 50));
        workLabel.text = "Work";
        workLabel.font = UIFont(name: "Montserrat-Bold", size: 22);
        workLabel.textColor = UIColor().workPurple();
        workLabel.textAlignment = NSTextAlignment.Center;
        
        workTime = UILabel(frame: CGRectMake(0, (height * 0.4), width, 125));
        workTime.font = UIFont(name: "Montserrat-Bold", size: 100);
        workTime.textColor = UIColor().workPurple();
        workTime.textAlignment = NSTextAlignment.Center;
        
        self.addSubview(workLabel);
        self.addSubview(workTime);
    }
    func updateTime(secs: Int){
        var m = (secs / 60) % 60;
        var s = secs % 60;
        
        var formattedTime: NSString = String(format: "%02u:%02u", m, s);
        workTime.text = formattedTime
    }
    func startTimer(){
        updateTime(Int(timerObj.getWorkSeconds()))
    }
    func stopTimer(){
        
    }
}