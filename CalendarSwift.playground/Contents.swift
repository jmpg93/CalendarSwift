import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
let view = MonthView(frame: frame)
let viewModel = MonthViewModel(month: .current, mode: Mode.monthly)

view.load(with: viewModel)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
