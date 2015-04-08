

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            println("------------------------------")
            println("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName as! String)
            println("Font Names = [\(names)]")
        }
    }
    
    GAI.sharedInstance().trackUncaughtExceptions = true;
    GAI.sharedInstance().dispatchInterval = 20;
    GAI.sharedInstance().trackerWithTrackingId("UA-59048243-1");
    
//    printFonts()
    return true
  }
  
}

