
import Foundation
import UIKit
import TempoSharedFramework

public class HomeView: UIView {
    var beginButton: UIButton!
    var countDownLabel: UILabel!
    var width: CGFloat!
    var height: CGFloat!
    var timerObj: TimerModel!{
        willSet(x){
            countDownLabel.text = String(x.getStartSeconds());
        }
    }
    var beginBlock: (() -> ())?


    override init(frame: CGRect) {
        
        super.init(frame: frame)
        width = frame.size.width
        height = frame.size.height
        initialize()
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initialize(){
        // Create the "Begin" button
        beginButton = UIButton(frame: CGRectMake(0, (height * 0.1), width, (height * 0.75)));
        beginButton.alpha = 1.0;
        beginButton.setTitle("begin", forState:UIControlState.Normal);
        beginButton.setTitleColor(UIColor().intervalGreen(), forState: UIControlState.Normal);
        beginButton.titleLabel!.font = UIFont(name: "Montserrat-Bold", size: 36);
        beginButton.addTarget(self, action: "beginPressed", forControlEvents: UIControlEvents.TouchUpInside);
        self.addSubview(beginButton)
        
        // Setup the Countdown Label
        countDownLabel = UILabel(frame: CGRectMake(0, (height * 0.1), width, (height * 0.75)));
        countDownLabel.textAlignment = NSTextAlignment.Center;
        countDownLabel.textColor = UIColor().intervalGreen();
        countDownLabel.font = UIFont(name: "Montserrat-Bold", size: 125);
        stopTimer()
        self.addSubview(countDownLabel)
        
    }
    func startTimer(){
        beginButton.alpha = 0
        countDownLabel.alpha = 1
    }
    func stopTimer(){
        beginButton.alpha = 1
        countDownLabel.alpha = 0
        if((timerObj) != nil){
            countDownLabel.text = String(timerObj.getStartSeconds())
    
        }
    }
    func beginPressed(){
        beginBlock?()
    }
    func updateTime(seconds: Int){
        countDownLabel.text = String(seconds)
    }
}