import UIKit

class HorizontalFillFlowLayout: UICollectionViewLayout {
    private weak var delegate: CollectionViewLayoutDelegate?
    public var mode: Mode = .weekly
    
    var cellAttrsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    var contentSize = CGSize.zero
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mode = .monthly
        delegate = nil
    }
    
    convenience init(delegate: CollectionViewLayoutDelegate, mode: Mode = .weekly) {
        self.init()
        self.mode = mode
        self.delegate = delegate
    }
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    func indalivateLayoutIfNeeded(for mode: Mode) {
        if shouldInvalidate(for: mode) {
            invalidateLayout()
        }
    }
    
    func shouldInvalidate(for mode: Mode) -> Bool {
        return self.mode != mode
    }
    
    override func prepare() {
        guard let delegate = delegate else {
            return
        }
        
        let weekDays = delegate.numberOfWeekDays()
        let width = collectionView!.bounds.size.width

        let cellWidth = width / CGFloat(weekDays)
        let cellHeight = cellWidth
        
        let numberOfRows = mode.numberOfRows
        var sectionOffset: CGFloat = 0
        var lastRelativeSectionIndex: Int = 0
        
        for section in 0...collectionView!.numberOfSections - 1 {
            sectionOffset += width * CGFloat(section + lastRelativeSectionIndex)
            for item in 0...collectionView!.numberOfItems(inSection: section) - 1 {
                let dayIndex = item % weekDays
                let rowIndex = (item / weekDays) % numberOfRows
                
                let relativeSectionIndex = item / (weekDays * numberOfRows)
                let relativeSectionOffset = CGFloat(relativeSectionIndex) * width
                lastRelativeSectionIndex = relativeSectionIndex
                
                let xPos = CGFloat(dayIndex) * cellWidth + sectionOffset + relativeSectionOffset
                let yPos = CGFloat(rowIndex) * cellHeight
                
                let cellIndex = IndexPath(item: item, section: section)
                let frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
                cellAttrsDictionary[cellIndex] = UICollectionViewLayoutAttributes(forCellWith: cellIndex, frame: frame)
            }
        }
        
        let contentHeight = cellHeight * CGFloat(numberOfRows)
        let contentWidth = sectionOffset
        
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Create an array to hold all elements found in our current view.
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        // Check each element to see if it should be returned.
        for cellAttributes in cellAttrsDictionary.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        // Return list of elements.
        return attributesInRect
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]!
    }
}

extension UICollectionViewLayoutAttributes {
    convenience init(forCellWith indexPath: IndexPath, frame: CGRect) {
        self.init(forCellWith: indexPath)
        self.frame = frame
    }
}
