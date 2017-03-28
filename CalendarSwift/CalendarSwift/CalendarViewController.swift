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
        daysView.delegate = self
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

extension CalendarViewController: DaysViewDelegate {
    public func daysView(_ daysView: DaysView, shouldSelectDay day: Day) -> Bool {
        return true
    }

    public func daysView(_ daysView: DaysView, willDisplay cell: DayCell, at day: Day) {
        let month = day.month
        let indexPath = day.indexPath
        
        let value = indexPath.row + 1 - month.inDates

        switch value {
        case Int.min...0:
            cell.update(value: "")
        case 1...month.numberOfDaysInMonth:
            cell.update(value: "\(value)")
        default:
            cell.update(value: "")
        }
        
    }
}
extension CalendarViewController: DaysViewDataSource {
    public func configureDaysView(_ daysView: DaysView) -> DaysViewConfiguration {
        return DaysViewConfiguration(mode: .weekly, firstWeekDay: .monday, calendar: calendar)
    }
}
