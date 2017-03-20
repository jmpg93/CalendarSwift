import Foundation

public struct Day {
    public enum WeekDay {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    public let value: String
    public let weekDay: WeekDay
    
    init(value: String, weekDay: WeekDay) {
        self.value = value
        self.weekDay = weekDay
    }
}
