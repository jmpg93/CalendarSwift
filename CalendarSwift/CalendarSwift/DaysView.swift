import UIKit

public class DaysView: UIView {
    private var collectionView: UICollectionView!
    
    public weak var delegate: DaysViewDelegate? {
        didSet { collectionView.delegate = self }
    }
    
    public weak var dataSource: DaysViewDataSource? {
        didSet { collectionView.dataSource = self }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func dequeueReusableCell(for indexPath: IndexPath) -> DayCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as! DayCell
    }
    
    private func commonInit() {
        let layout = CustomCollectionViewLayout(delegate: self)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
        collectionView.pinTo(view: self)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DaysView: CollectionViewLayoutDelegate {
    func numberOfWeekDays() -> Int {
        return dataSource?.numberOfWeekDays() ?? 0
    }
}

extension DaysView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfMonths() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfDays(in: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource?.daysView(self, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
}

extension DaysView: UICollectionViewDelegate {
    
}
