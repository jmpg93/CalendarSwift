import Foundation

public struct Month {
    
    /// Start index day for the month.
    /// The start is total number of days of previous months
    let startDayIndex: Int
    
    /// Start cell index for the month.
    /// The start is total number of cells of previous months
    let startCellIndex: Int
    
    /// The total number of items in this array are the total number
    /// of sections. The actual number is the number of items in each section
    let sections: [Int]
    
    /// Number of inDates for this month
    let inDates: Int
    
    /// Number of outDates for this month
    let outDates: Int
    
    // Maps a section to the index in the total number of sections
    let sectionIndexMaps: [Int: Int]
    
    // Number of rows for the month
    let rows: Int
    
    // Return the total number of days for the represented month
    var numberOfDaysInMonth: Int
    
    // Return the total number of day cells
    // to generate for the represented month
    var numberOfDaysInMonthGrid: Int {
        get { return numberOfDaysInMonth + inDates + outDates }
    }
    
    var startSection: Int {
        return sectionIndexMaps.keys.min()!
    }
    
    // Return the section in which a day is contained
    func indexPath(forDay number: Int) -> IndexPath? {
        let sectionInfo = sectionFor(day: number)
        let externalSection = sectionInfo.externalSection
        let internalSection = sectionInfo.internalSection
        let dateOfStartIndex = sections[0..<internalSection].reduce(0, +) - inDates + 1
        let itemIndex = number - dateOfStartIndex
        
        return IndexPath(item: itemIndex, section: externalSection)
    }
    
    private func sectionFor(day: Int) -> (externalSection: Int, internalSection: Int) {
        var variableNumber = day
        let possibleSection = sections.index {
            let retval = variableNumber + inDates <= $0
            variableNumber -= $0
            return retval
            }!
        
        let key = sectionIndexMaps.keys[sectionIndexMaps.keys.index(of: possibleSection)!]
        return (key, possibleSection)
    }
    
    // Return the number of rows for a section in the month
    func numberOfRows(for section: Int, developerSetRows: Int) -> Int {
        var retval: Int
        guard let theSection = sectionIndexMaps[section] else {
            return 0
        }
        let fullRows = rows / developerSetRows
        let partial = sections.count - fullRows
        
        if theSection + 1 <= fullRows {
            retval = developerSetRows
        } else if fullRows == 0 && partial > 0 {
            retval = rows
        } else {
            retval = 1
        }
        return retval
    }
    
    // Returns the maximum number of a rows for a completely full section
    func maxNumberOfRowsForFull(developerSetRows: Int) -> Int {
        var retval: Int
        let fullRows = rows / developerSetRows
        if fullRows < 1 {
            retval = rows
        } else {
            retval = developerSetRows
        }
        return retval
    }
    
    func boundaryIndicesFor(section: Int) -> (startIndex: Int, endIndex: Int)? {
        // Check internal sections to see
        if !(0..<sections.count ~=  section) {
            return nil
        }
        let startIndex = section == 0 ? inDates : 0
        var endIndex =  sections[section] - 1
        if section + 1  == sections.count {
            endIndex -= inDates + 1
        }
        return (startIndex: startIndex, endIndex: endIndex)
    }
}
