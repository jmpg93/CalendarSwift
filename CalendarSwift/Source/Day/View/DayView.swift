//
//  DayView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

open class DayView: UICollectionViewCell {
	fileprivate var dayLabel: UILabel!

	public override init(frame: CGRect) {
		super.init(frame: frame)
		dayLabel = UILabel(frame: frame)
		dayLabel.textAlignment = .center
		dayLabel.backgroundColor = .white
		dayLabel.constraintToBounds(of: self)
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		dayLabel = UILabel(coder: aDecoder)
		dayLabel.textAlignment = .center
		dayLabel.constraintToBounds(of: self)
	}

	open func setUp(with model: DayViewModelProtocol) {
		self.dayLabel.text = model.dayValue
	}
}
