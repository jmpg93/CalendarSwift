import UIKit
import CalendarSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let months = TimeInterval(4 * 60 * 60 * 24 * 30)
        let begin = Date()
        let end = begin.addingTimeInterval(months)
        
        let range = Cal.Range.limited(begin: begin, end: end)
        let cal = Cal(range: range)
        
        cal.months

        
        return true
    }
}

