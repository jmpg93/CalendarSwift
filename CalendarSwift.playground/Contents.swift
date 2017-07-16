import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let date = Date().addingTimeInterval(60*60*24*30)
let month = Month(date: Date())
let viewModel = MonthViewModel(month: month)

let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
let view = MonthView(frame: frame)
view.load(with: viewModel)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
