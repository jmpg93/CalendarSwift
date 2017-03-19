import Foundation
import UIKit

class DayCell: UICollectionViewCell {
    private var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        //layoutMargins = .zero

        valueLabel = UILabel()
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        
        let margins = layoutMarginsGuide
        valueLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo:margins.bottomAnchor).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
        
    }
    
    func update(value: String) {
        self.valueLabel.text = value
    }
}
