import Foundation

public struct Day {
    public enum WeekDay {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    public let value: String
    public let indexPath: IndexPath
    public let month: Month
    public let weekDay: WeekDay
    public let isSelected: Bool
    
    init(value: String, weekDay: WeekDay, month: Month, indexPath: IndexPath, isSelected: Bool) {
        self.value = value
        self.weekDay = weekDay
        self.indexPath = indexPath
        self.isSelected = isSelected
        self.month = month
    }
}
