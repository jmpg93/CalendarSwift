import Foundation
import UIKit

public class CalendarViewController: UIViewController {
    @IBOutlet weak var weekDaysView: WeekDaysView!
    @IBOutlet weak var daysView: DaysView!
    
    fileprivate let calendar = Cal()
    
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
    public func numberOfWeekDays() -> Int {
        return calendar.calendar.weekdaySymbols.count
    }
    
    public func weekDaysView(_ weekDaysView: WeekDaysView, cellForItemAt indexPath: IndexPath) -> WeekDayCell {
        let cell = weekDaysView.dequeueReusableCell(withReuseIdentifier: "WeekDayCell", for: indexPath)
        let day = calendar.calendar.weekdaySymbols[indexPath.row]
        cell.update(value: day)
        return cell
    }
}

extension CalendarViewController: DaysViewDataSource {
    public func numberOfMonths() -> Int {
        return calendar.months.count
    }
    
    public func numberOfDays(in month: Int) -> Int {
        return calendar.months[month].numberOfDaysInMonth
    }
    
    public func daysView(_ daysView: DaysView, cellForItemAt indexPath: IndexPath) -> DayCell {
        let cell = daysView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .yellow
        case 1:
            cell.backgroundColor = .blue
        case 2:
            cell.backgroundColor = .green
        default:
            cell.backgroundColor = .purple
        }
        
        cell.update(value: "\(indexPath.row + 1)")
        return cell
    }
}
