import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let date = Date().addingTimeInterval(60*60*24*30)
let viewModel = CalendarViewModel(calendar: .current, startDate: date)


let view = CalendarView.instanceFromNib()
view.load(with: viewModel)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
