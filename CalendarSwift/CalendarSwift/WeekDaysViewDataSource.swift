import Foundation

public protocol WeekDaysViewDataSource: class {
    func numberOfWeekDays() -> Int
    func weekDaysView(_ weekDaysView: WeekDaysView, cellForItemAt indexPath: IndexPath) -> WeekDayCell
}
