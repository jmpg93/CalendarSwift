import Foundation
import UIKit

public class CalendarViewController: UIViewController {
    @IBOutlet weak var weekDaysView: WeekDaysView!
    @IBOutlet weak var daysView: DaysView!
    
    public let calendar = Cal()
    
    public static func initFromStoryboard() -> CalendarViewController {
        let bundle = Bundle(for: CalendarViewController.self)
        return UIStoryboard.init(name: "CalendarViewController", bundle: bundle).instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        daysView.dataSource = self
        weekDaysView.dataSource = self
    }
}

extension CalendarViewController: WeekDaysViewDataSource {
    public func weeekDay(at indexPath: IndexPath, style: WeekDayStyle) -> String {
        return calendar.symbols(for: style)[indexPath.row]
    }
    
    public func numberOfWeekDays() -> Int {
        return calendar.weekdaySymbols.count
    }
}

extension CalendarViewController: DaysViewDataSource {
    public var firstWeekDay: Day.WeekDay {
        return calendar.firstWeekDay
    }
    
    public func numberOfMonths() -> Int {
        return calendar.months.count
    }
    
    public func numberOfDays(in month: Int) -> Int {
        return calendar.months[month].numberOfDaysInMonthGrid
    }
    
    public func daysView(_ daysView: DaysView, cellForItemAt indexPath: IndexPath) -> DayCell {
        let cell = daysView.dequeueReusableCell(for: indexPath)
        let month = calendar.months[indexPath.section]
        
        let value = indexPath.row + 1 - month.inDates
        
        switch value {
        case Int.min...0:
            cell.update(value: "")
        case 1...month.numberOfDaysInMonth:
            cell.update(value: "\(value)")
        default:
            cell.update(value: "")
        }
        
        return cell
    }
}
