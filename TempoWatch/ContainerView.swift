

import Foundation
import UIKit

class ContainerView: UIView{
    var scrollView: UIScrollView!
    var menuOpen: Bool = false
    var disableScrolling = false
    
    var pauseImg: UIImage!
    var playImg: UIImage!
    var pauseImgV: UIImageView!
    var smallFrame: CGRect!
    var partialFrame: CGRect!
    var bigFrame: CGRect!
    
    var width: CGFloat!
    var height: CGFloat!
    
    override init(frame:CGRect){
        super.init(frame:frame)
        width = frame.size.width
        height = frame.size.height
        initialize()
    }
    
    required init(coder aDeCoder:NSCoder){
        super.init(coder:aDeCoder)
    }
    
    func initialize(){
        width = self.frame.size.width
        height = self.frame.size.height
        
        scrollView = UIScrollView(frame: self.frame)
        scrollView.contentSize = CGSizeMake((width * 2.0) - 45.0, height);
        scrollView.scrollEnabled = false;
        scrollView.pagingEnabled = false;
        scrollView.backgroundColor = UIColor.whiteColor();
        scrollView.showsHorizontalScrollIndicator = false
        super.addSubview(scrollView)
        
        
        smallFrame = CGRectMake((width - 50)/2, (height - 50)/2, 50, 50)
        let partialH = height * 0.8
        let partialW = width * 0.8
        partialFrame = CGRectMake((width - partialW)/2, (height - partialH)/2, partialW, partialH)
        bigFrame = CGRectMake(0, 0, width, height)
        pauseImg = UIImage(named:"pause")
        playImg = UIImage(named: "play")
        pauseImgV = UIImageView(frame: smallFrame)
        pauseImgV.contentMode = .ScaleAspectFill
        self.addSubview(pauseImgV)
        
        addGestures()
    }
    override func addSubview(view: UIView) {
        scrollView.addSubview(view)
    }
    func showPauseAnimation(pause:Bool){
        self.bringSubviewToFront(pauseImgV)
        pauseImgV.frame = smallFrame
        pauseImgV.alpha = 0
        pauseImgV.image = (pause) ? pauseImg : playImg
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseIn, animations: {
            println("animation started")
            self.pauseImgV.alpha = 0.10
        }, completion: { finished in
            println("animation continuing")
            UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: {
                self.pauseImgV.frame = self.partialFrame
                }, completion: { finished in
                    println("animation finishing")
                    UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
                        self.pauseImgV.frame = self.bigFrame
                        self.pauseImgV.alpha = 0
                        }, completion: { finished in
                            println("animation finished")
                    })
            })
        })
    }
    func addGestures(){
        var swipeRight: UISwipeGestureRecognizer =
            UISwipeGestureRecognizer(target: self, action:"viewWasSwiped:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        swipeRight.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(swipeRight);
        
        var swipeLeft: UISwipeGestureRecognizer =
            UISwipeGestureRecognizer(target: self, action: "viewWasSwiped:");
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        swipeLeft.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(swipeLeft);
    }

    func toggleMenuOpen(){
        if(disableScrolling){return;}
        if( menuOpen ){
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true);
            menuOpen = false;
        } else {
            scrollView.setContentOffset(CGPointMake(width - 45, 0), animated: true);
            menuOpen = true;
        }
    }
    func viewWasSwiped(gesture: UIGestureRecognizer){
        if(disableScrolling){return;}
        self.endEditing(true);
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if( swipeGesture.direction == UISwipeGestureRecognizerDirection.Right){
                scrollView.setContentOffset(CGPointMake(0, 0), animated: true);
                menuOpen = false;
            } else if( swipeGesture.direction == UISwipeGestureRecognizerDirection.Left ){
                scrollView.setContentOffset(CGPointMake(width - 45, 0), animated: true);
                menuOpen = true;
            }
        }
    }
    
    func menuClicked() {
        toggleMenuOpen()
    }
    
}
