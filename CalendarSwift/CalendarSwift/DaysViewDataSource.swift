import Foundation

public protocol DaysViewDataSource: class {
    func configureDaysView(_ daysView: DaysView) -> DaysViewConfiguration
}
