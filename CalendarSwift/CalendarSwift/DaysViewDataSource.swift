import Foundation

public protocol DaysViewDataSource: class {
    var firstWeekDay: Day.WeekDay { get }
    func numberOfWeekDays() -> Int
    
    func numberOfMonths() -> Int
    func numberOfDays(in month: Int) -> Int
    func daysView(_ daysView: DaysView, cellForItemAt indexPath: IndexPath) -> DayCell
}
