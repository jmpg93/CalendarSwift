import Foundation

public struct Cal {
    public enum Range {
        case limited(begin: Date, end: Date)
        case infinite
    }
    
    public let range: Range
    public let calendar: Calendar
    
    public let maxNumberOfDaysInWeek = 7
    public let numberOfRowsPerSectionThatUserWants = 4
    
    public init(calendar: Calendar = .current, range: Range = .infinite) {
        self.calendar = calendar
        self.range = range.withStartingDays(on: calendar)
    }
    
    public var months: [Month] {
        return months(in: range)
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
            print("Searching for days in month \(monthIndex)")
            guard let currentMonthDate = calendar.date(byAdding: .month, value: monthIndex, to: range.begin) else {
                print("Month date could not be created for date \(range.begin) and month index \(monthIndex)")
                break
            }
            
            var numberOfDaysInMonthVariable = calendar.range(of: .day, in: .month, for: currentMonthDate)!.count
            let numberOfDaysInMonthFixed = numberOfDaysInMonthVariable
            var numberOfRowsToGenerateForCurrentMonth = 0
            let numberOfPreDatesForThisMonth = 0
            
            print("Month \(monthIndex) has \(numberOfDaysInMonthVariable) days")
            
            let actualNumberOfRowsForThisMonth = Int(ceil(Float(numberOfDaysInMonthVariable) / Float(maxNumberOfDaysInWeek)))
            numberOfRowsToGenerateForCurrentMonth = actualNumberOfRowsForThisMonth
            
            print("Month \(monthIndex) has \(actualNumberOfRowsForThisMonth) rows")
            
            let numberOfPostDatesForThisMonth = maxNumberOfDaysInWeek * numberOfRowsToGenerateForCurrentMonth - (numberOfDaysInMonthFixed + numberOfPreDatesForThisMonth)
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
                
                var numberOfDaysInCurrentSection = numberOfRowsPerSectionThatUserWants * maxNumberOfDaysInWeek
                
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
            
            print("--")
            print("Month \(monthIndex) has \(startIndexForMonth) startIndexForMonth")
            print("Month \(monthIndex) has \(startCellIndexForMonth) startCellIndexForMonth")
            print("Month \(monthIndex) has \(sectionsForTheMonth) sectionsForTheMonth")
            print("Month \(monthIndex) has \(numberOfPreDatesForThisMonth) numberOfPreDatesForThisMonth")
            print("Month \(monthIndex) has \(numberOfPostDatesForThisMonth) numberOfPostDatesForThisMonth")
            print("Month \(monthIndex) has \(sectionIndexMaps) sectionIndexMaps")
            print("Month \(monthIndex) has \(numberOfRowsToGenerateForCurrentMonth) numberOfRowsToGenerateForCurrentMonth")
            print("Month \(monthIndex) has \(numberOfDaysInMonthFixed) numberOfDaysInMonthFixed")
            print("--")
            
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
            
            print("")
        }
        
        return monthArray
    }
}


extension Cal.Range {
    func withStartingDays(on calendar: Calendar) -> Cal.Range {
        switch self {
        case .infinite:
            return .infinite
        case .limited(let begin, let end):
            return .limited(begin: calendar.startOfDay(for: begin),
                            end: calendar.startOfDay(for: end))
        }
    }
    
    //TODO: Set up infinite date
    var begin: Date {
        switch self {
        case .infinite:
            return Date()
        case .limited(let begin, _):
            return begin
        }
    }
    
    //TODO: Set up infinite date
    var end: Date {
        switch self {
        case .infinite:
            return Date()
        case .limited(_, let end):
            return end
        }
    }
}
