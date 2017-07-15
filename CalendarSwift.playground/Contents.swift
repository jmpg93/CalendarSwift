import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let date = Date().addingTimeInterval(60*60*24*30)
let monthViewModel = MonthViewModel(month: Month(date: date))

let view = MonthView.instanceFromNib()
view.load(with: monthViewModel)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
