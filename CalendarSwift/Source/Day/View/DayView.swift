//
//  DayView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

open class DayView: UICollectionViewCell {
	@IBOutlet weak var dayLabel: UILabel!

	open func setUp(with model: DayViewModelProtocol) {
		self.dayLabel.text = model.dayValue
	}
}
