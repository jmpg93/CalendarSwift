import Foundation
import UIKit

protocol CollectionViewLayoutDelegate: class {
    func numberOfWeekDays() -> Int
}

public class CollectionViewLayout: UICollectionViewFlowLayout {
    private weak var delegate: CollectionViewLayoutDelegate!
    
    override init() {
        super.init()
    }
    
    convenience init(delegate: CollectionViewLayoutDelegate) {
        self.init()
        
        self.delegate = delegate
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
       return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        print(proposedContentOffset)
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }

    public override func prepare() {
        super.prepare()
        let size = collectionView!.bounds.width / CGFloat(delegate.numberOfWeekDays())
        itemSize = CGSize(width: size, height: size)
    }
    
    var calculatedColumnCount: CGFloat = 0
    var calculatedLineCount: CGFloat = 0
    var layoutAttributesArray: [UICollectionViewLayoutAttributes] = []
    var columnCount: CGFloat = 0
    
    private func commonInit() {
        scrollDirection = .horizontal
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        sectionInset = .zero
    }
}

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
        let layout = CollectionViewLayout(delegate: self)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.register(WeekDayCell.self, forCellWithReuseIdentifier: WeekDayCell.reuseIdentifier)
        collectionView.pinTo(view: self)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension WeekDaysView: CollectionViewLayoutDelegate {
    
    func numberOfWeekDays() -> Int {
        return dataSource!.numberOfWeekDays()
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
