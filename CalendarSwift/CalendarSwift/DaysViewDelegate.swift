import Foundation

public protocol DaysViewDelegate: class {
    func daysView(_ daysView: DaysView, willDisplay cell: DayCell, at day: Day)
    func daysView(_ daysView: DaysView, shouldSelectDay day: Day) -> Bool
}
