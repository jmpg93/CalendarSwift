import Foundation

public protocol WeekDaysViewDataSource: class {
    var weekDayStyle: WeekDayStyle { get }
    
    func numberOfWeekDays() -> Int
    func weeekDay(at indexPath: IndexPath, style: WeekDayStyle) -> String
}

extension WeekDaysViewDataSource {
    public var weekDayStyle: WeekDayStyle {
        return .veryShort
    }
}

public enum WeekDayStyle {
    case veryShort
    case short
    case standalone
}
