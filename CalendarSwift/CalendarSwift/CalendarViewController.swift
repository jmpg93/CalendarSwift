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
        
        daysView?.delegate = self
        daysView?.dataSource = self
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendar.months.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.months[section].numberOfDaysInMonth
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        
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
        
        cell.update(value: String(indexPath.row))
        
        return cell
    }
    
}

extension CalendarViewController: UICollectionViewDelegate {
    
}

