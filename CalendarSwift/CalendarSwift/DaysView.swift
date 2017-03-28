import UIKit

public class DaysView: UIView {
    public var configuration: DaysViewConfiguration!
    
    private var collectionView: UICollectionView!
    
    private var layout: HorizontalFillFlowLayout {
        return collectionView.collectionViewLayout as! HorizontalFillFlowLayout
    }
    
    public weak var delegate: DaysViewDelegate? {
        didSet { self.collectionView.delegate = self }
    }
    
    public weak var dataSource: DaysViewDataSource? {
        didSet {
            updateConfiguration()
            self.collectionView.dataSource = self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
        
    func reloadCalendar() {
        updateConfiguration()
        updateLayoutIfNeeded()
        collectionView.reloadData()
    }
    
    private func updateConfiguration() {
        guard let dataSource = dataSource else {
            fatalError("Error: No data source")
        }
        configuration = dataSource.configureDaysView(self)
    }
    
    private func updateLayoutIfNeeded() {
        guard let configuration = configuration else {
            fatalError("Error: No configuration")
        }
        
        if let layout = collectionView.collectionViewLayout as? HorizontalFillFlowLayout {
            layout.indalivateLayoutIfNeeded(for: configuration.mode)
        } else {
            let layout = HorizontalFillFlowLayout(delegate: self, mode: configuration.mode)
            collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    private func commonInit() {
        let layout = HorizontalFillFlowLayout(delegate: self)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.pinTo(view: self)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension DaysView: CollectionViewLayoutDelegate {
    func numberOfWeekDays() -> Int {
        return configuration.calendar.weekdaySymbols.count
    }
}

extension DaysView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return configuration.calendar.months.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configuration.calendar.months[section].numberOfDaysInMonthGrid
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? DayCell else {
            print("Cell is no DayCell")
            return
        }

        let day = configuration.calendar.day(at: indexPath)
        delegate!.daysView(self, willDisplay: cell, at: day)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as! DayCell
    }
}

extension DaysView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let delegate = delegate else {
            return false
        }
        
        let day = configuration.calendar.day(at: indexPath)
        return delegate.daysView(self, shouldSelectDay: day)
    }
}
