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
    
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> DayCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DayCell
    }
    
    private func commonInit() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.pinTo(view: self)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
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
