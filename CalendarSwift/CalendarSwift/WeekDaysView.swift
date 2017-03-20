import Foundation
import UIKit

public class WeekDaysView: UIView {
    private var collectionView: UICollectionView!
    
    public weak var delegate: WeekDaysViewDelegate? {
        didSet { collectionView.delegate = self }
    }
    
    public weak var dataSource: WeekDaysViewDataSource? {
        didSet { collectionView.dataSource = self }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func dequeueReusableCell(for indexPath: IndexPath) -> WeekDayCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: WeekDayCell.reuseIdentifier, for: indexPath) as! WeekDayCell
    }
    
    private func commonInit() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(WeekDayCell.self, forCellWithReuseIdentifier: WeekDayCell.reuseIdentifier)
        collectionView.pinTo(view: self)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension WeekDaysView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource!.numberOfWeekDays()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(for: indexPath)
        let day = dataSource!.weeekDay(at: indexPath, style: dataSource!.weekDayStyle)
        cell.update(value: day)
        return cell
        
    }
    
}

extension WeekDaysView: UICollectionViewDelegate {
    
}
