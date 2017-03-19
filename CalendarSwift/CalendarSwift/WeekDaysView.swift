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
    
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> WeekDayCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WeekDayCell
    }
    
    private func commonInit() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "WeekDayCell")
        collectionView.pinTo(view: self)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension WeekDaysView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfWeekDays() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource?.weekDaysView(self, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
}

extension WeekDaysView: UICollectionViewDelegate {
    
}
