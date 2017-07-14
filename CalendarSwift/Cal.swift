import Foundation

public struct Cal {
    public enum Range {
        case limited(begin: Date, end: Date)
        case infinite
    }
    
    fileprivate let calendar: Calendar
    public let range: Range
    public private(set) var months: [Month] = []
    
    public let numberOfDaysInWeek = 7
    public let numberOfRowsPerSectionThatUserWants = 4
    public var firstWeekDay: Day.WeekDay = .monday
    
    public init(calendar: Calendar = .current, range: Range = .infinite) {
        self.calendar = calendar
        self.range = range.withStartingDays(on: calendar)
        
        reload()
    }
    
    mutating func reload() {
        months = months(in: range)
    }
    
    // Private funcs 
    
    private func months(in range: Range) -> [Month] {
        let differenceComponents = calendar.dateComponents([.month], from: range.begin, to: range.end)
        let numberOfMonths = differenceComponents.month! + 1
        print("Number of months: \(numberOfMonths)")
        
        var monthArray: [Month] = []
        var monthIndexMap: [Int: Int] = [:]
        var section = 0
        var startIndexForMonth = 0
        var startCellIndexForMonth = 0
        var totalDays = 0
        
        for monthIndex in 0 ..< numberOfMonths {
            print("*****MONTH \(monthIndex)*****")

            guard let currentMonthDate = calendar.date(byAdding: .month, value: monthIndex, to: range.begin) else {
                print("Month date could not be created for date \(range.begin) and month index \(monthIndex)")
                break
            }
            
            var numberOfDaysInMonthVariable = calendar.range(of: .day, in: .month, for: currentMonthDate)!.count
            let numberOfDaysInMonthFixed = numberOfDaysInMonthVariable
            var numberOfRowsToGenerateForCurrentMonth = 0
            var numberOfPreDatesForThisMonth = 0
            
            print("Month \(monthIndex) has \(numberOfDaysInMonthVariable) days")
            
            //Predates
            numberOfPreDatesForThisMonth = numberOfPreDatesForMonth(currentMonthDate, firstDayOfWeek: firstWeekDay, calendar: calendar)
            numberOfDaysInMonthVariable += numberOfPreDatesForThisMonth
            
            //Postdates
            let actualNumberOfRowsForThisMonth = Int(ceil(Float(numberOfDaysInMonthVariable) / Float(numberOfDaysInWeek)))
            numberOfRowsToGenerateForCurrentMonth = actualNumberOfRowsForThisMonth
            print("Month \(monthIndex) has \(actualNumberOfRowsForThisMonth) rows")
            
            let numberOfPostDatesForThisMonth =
                numberOfDaysInWeek * numberOfRowsToGenerateForCurrentMonth - (numberOfDaysInMonthFixed + numberOfPreDatesForThisMonth)
            numberOfDaysInMonthVariable += numberOfPostDatesForThisMonth
            
            print("Month \(monthIndex) will generate \(numberOfRowsToGenerateForCurrentMonth) rows")
            print("Month \(monthIndex) has \(numberOfDaysInMonthVariable) days now")
            
            var sectionsForTheMonth: [Int] = []
            var sectionIndexMaps: [Int: Int] = [:]
            for index in 0..<6 {
                // Max number of sections in the month
                if numberOfDaysInMonthVariable < 1 {
                    break
                }
                
                monthIndexMap[section] = monthIndex
                sectionIndexMaps[section] = index
                
                var numberOfDaysInCurrentSection = numberOfRowsPerSectionThatUserWants * numberOfDaysInWeek
                
                if numberOfDaysInCurrentSection > numberOfDaysInMonthVariable {
                    numberOfDaysInCurrentSection = numberOfDaysInMonthVariable
                    // assert(false)
                }
                
                totalDays += numberOfDaysInCurrentSection
                sectionsForTheMonth.append(numberOfDaysInCurrentSection)
                numberOfDaysInMonthVariable -= numberOfDaysInCurrentSection
                section += 1
                
                print("Month \(monthIndex) has \(numberOfDaysInCurrentSection) days in section \(index)")
                
            }
            
            print("--RESUME--")
            print("Month \(monthIndex) has \(startIndexForMonth) startIndexForMonth")
            print("Month \(monthIndex) has \(startCellIndexForMonth) startCellIndexForMonth")
            print("Month \(monthIndex) has \(sectionsForTheMonth) sectionsForTheMonth")
            print("Month \(monthIndex) has \(numberOfPreDatesForThisMonth) numberOfPreDatesForThisMonth")
            print("Month \(monthIndex) has \(numberOfPostDatesForThisMonth) numberOfPostDatesForThisMonth")
            print("Month \(monthIndex) has \(sectionIndexMaps) sectionIndexMaps")
            print("Month \(monthIndex) has \(numberOfRowsToGenerateForCurrentMonth) numberOfRowsToGenerateForCurrentMonth")
            print("Month \(monthIndex) has \(numberOfDaysInMonthFixed) numberOfDaysInMonthFixed")
            print("----------")
            
            monthArray.append(Month(
                startDayIndex: startIndexForMonth,
                startCellIndex: startCellIndexForMonth,
                sections: sectionsForTheMonth,
                inDates: numberOfPreDatesForThisMonth,
                outDates: numberOfPostDatesForThisMonth,
                sectionIndexMaps: sectionIndexMaps,
                rows: numberOfRowsToGenerateForCurrentMonth,
                numberOfDaysInMonth: numberOfDaysInMonthFixed
            ))
            
            startIndexForMonth += numberOfDaysInMonthFixed
            startCellIndexForMonth += numberOfDaysInMonthFixed + numberOfPreDatesForThisMonth + numberOfPostDatesForThisMonth
            
            print("*****************")
        }
        
        return monthArray
    }
    
    private func numberOfPreDatesForMonth(_ date: Date, firstDayOfWeek: Day.WeekDay, calendar: Calendar) -> Int {
        let firstDayCalValue: Int
        switch firstDayOfWeek {
        case .monday: firstDayCalValue = 6
        case .tuesday: firstDayCalValue = 5
        case .wednesday: firstDayCalValue = 4
        case .thursday: firstDayCalValue = 10
        case .friday: firstDayCalValue = 9
        case .saturday: firstDayCalValue = 8
        default: firstDayCalValue = 7
        }
        
        var firstWeekdayOfMonthIndex = calendar.component(.weekday, from: date)
        firstWeekdayOfMonthIndex -= 1
        // firstWeekdayOfMonthIndex should be 0-Indexed
        // push it modularly so that we take it back one day so that the
        // first day is Monday instead of Sunday which is the default
        return (firstWeekdayOfMonthIndex + firstDayCalValue) % numberOfDaysInWeek
    }
    
    func day(at indexPath: IndexPath) -> Day {
        let month = months[indexPath.section]
        print("Sections", month.sections)
        print("sectionIndexMaps", month.sectionIndexMaps)
        return Day(value: "'", weekDay: .monday, month: months.first!, indexPath: indexPath, isSelected: false)
    }
}

extension Cal {
    public func symbols(for style: WeekDayStyle) -> [String] {
        switch style {
        case .veryShort:
            return veryShortWeekdaySymbols
        case .short:
            return shortWeekdaySymbols
        case .standalone:
            return weekdaySymbols
        }
    }
    
    public var weekdaySymbols: [String] {
        return calendar.weekdaySymbols
    }

    public var shortWeekdaySymbols: [String]  {
        return calendar.shortWeekdaySymbols
    }

    public var veryShortWeekdaySymbols: [String]  {
        return calendar.veryShortWeekdaySymbols
    }
}

extension Cal.Range {
    private var monthTimeInterval: TimeInterval {
        return 31 * 60 * 60 * 24
    }
    
    func withStartingDays(on calendar: Calendar) -> Cal.Range {
        switch self {
        case .infinite:
            return .infinite
        case .limited(let begin, let end):
            return .limited(begin: calendar.startOfDay(for: begin),
                            end: calendar.startOfDay(for: end))
        }
    }
    
    var begin: Date {
        switch self {
        case .infinite:
            return Date().addingTimeInterval(-monthTimeInterval)
        case .limited(let begin, _):
            return begin
        }
    }

    var end: Date {
        switch self {
        case .infinite:
            return Date().addingTimeInterval(monthTimeInterval)
        case .limited(_, let end):
            return end
        }
    }
}
