import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let monthViewModel = MonthViewModel(month: Month(date: Date()))

let view = MonthView.instanceFromNib()
view.load(with: monthViewModel)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
