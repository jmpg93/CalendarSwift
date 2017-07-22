//
//  CalendarHeaderView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 19/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class HeaderView: UICollectionViewCell {
	fileprivate var stackView: UIStackView!

	convenience init() {
		self.init(frame: .zero)
		commonInit()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}

	func commonInit()  {
		stackView = UIStackView()
		stackView.constraintToBounds(of: self)
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.alignment = .center
	}
}

extension HeaderView {
	func load(with models: [String]) {
		if stackView.arrangedSubviews.isEmpty {
			models.map(UILabel.init).forEach(stackView.addArrangedSubview)

		} else if let labels = stackView.arrangedSubviews as? [UILabel] {
			for (index, model) in models.enumerated() {
				labels[index].text = model
			}
		}
	}
}
