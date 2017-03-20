import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    private weak var delegate: CollectionViewLayoutDelegate!
    
    var cellAttrsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    var contentSize = CGSize.zero
    
    override init() {
        super.init()
    }
    
    convenience init(delegate: CollectionViewLayoutDelegate) {
        self.init()
        
        self.delegate = delegate
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        let sectionDaysSize = 7
        let weekDays = delegate.numberOfWeekDays()
        
        let relativeSectionRatio = CGFloat(sectionDaysSize / weekDays)
        
        let width = collectionView!.bounds.size.width
        let sectionWidth = width * relativeSectionRatio
        let sectionHeight = width
        let contentWidth = sectionWidth * CGFloat(collectionView!.numberOfSections)
        let contentHeight = sectionHeight
        
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)

        let cellWidth = width / CGFloat(weekDays)
        let cellHeight = cellWidth
        
        for section in 0...collectionView!.numberOfSections - 1 {
            let xPosSection = CGFloat(section) * sectionWidth
            for item in 0...collectionView!.numberOfItems(inSection: section) - 1 {
                let relativeItem = item % sectionDaysSize
                
                let xPos = CGFloat(relativeItem) * cellWidth + xPosSection
                let yPos = cellHeight * CGFloat(item / sectionDaysSize)
                
                let cellIndex = IndexPath(item: item, section: section)
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: cellHeight)
                cellAttrsDictionary[cellIndex] = cellAttributes
                
            }
        }
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
