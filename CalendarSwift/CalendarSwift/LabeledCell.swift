import Foundation
import UIKit

public class LabeledCell: UICollectionViewCell {
    private var valueLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        valueLabel = UILabel()
        valueLabel.textAlignment = .center
        valueLabel.pinTo(view: self)
    }
    
    public func update(value: String) {
        self.valueLabel.text = value
    }
}
