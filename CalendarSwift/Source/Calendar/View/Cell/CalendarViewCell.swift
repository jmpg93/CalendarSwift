//
//  CalendarViewCell.swift
//  CalendarSwift
//
//  Created by Jose Maria Puerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

public class CalendarViewCell: UICollectionViewCell {
	fileprivate var monthView: MonthView!
}

// MARK: Public methods

extension CalendarViewCell {
	public func setUp(with model: MonthViewModel) {
		monthView.load(with: model)
	}
}

// MARK: Private methods

fileprivate extension CalendarViewCell {
	
}