import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
let monthViewModel = MonthViewModel(month: Month(date: Date()))

let view = MonthView.instanceFromNib()
view.frame = frame
view.load(with: monthViewModel)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
