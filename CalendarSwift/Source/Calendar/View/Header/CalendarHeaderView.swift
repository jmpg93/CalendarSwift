//
//  CalendarHeaderView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 19/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class CalendarHeaderView: UICollectionViewCell {
	fileprivate let stackView: UIStackView

	override init(frame: CGRect) {
		stackView = UIStackView(frame: frame)

		super.init(frame: frame)

		stackView.constraintToBounds(of: self)
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.alignment = .fill
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CalendarHeaderView {
	func load(with models: [String]) {
		stackView.arrangedSubviews.forEach(stackView.removeArrangedSubview)

		models
			.map(UILabel.init)
			.forEach(stackView.addArrangedSubview)
	}
}
