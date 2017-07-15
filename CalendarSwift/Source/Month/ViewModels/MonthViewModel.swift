//
//  MonthViewModel.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import TimeSwift

open class MonthViewModel: NSObject {
	fileprivate let month: Month

	public init(month: Month) {
		self.month = month
	}
}

// MARK: Datasource methods

extension MonthViewModel {
	open func dayViewModel(at indexPath: IndexPath) -> DayViewModel {
		return DayViewModel(day: month.days[indexPath.item])
	}

	open func numberOfViewDays() -> Int {
		return month.numberOfDays
	}
}

// MARK: Layout methods

extension MonthViewModel {
	var minimumLineSpacing: CGFloat {
		return 0
	}

	var minimumInteritemSpacing: CGFloat {
		return 0
	}

	open func sizeForItem(at indexPath: IndexPath, in bounds: CGRect) -> CGSize {
		let itemsPerRow = CGFloat(month.numberOfWeekdays)
		let width = bounds.width / itemsPerRow

		return CGSize(width: width, height: width)
	}

	func inset(in bounds: CGRect) -> UIEdgeInsets {
		return .zero
	}
}

// MARK: Private methods

private extension MonthViewModel {

}
