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
	open func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		switch indexPath.row {
		case outOfTheMonthIndexRangeLeft, outOfTheMonthIndexRangeRight:
			return EmptyDayViewModel()
		case inTheMonthIndexRange:
			let relativeIndex = indexPath.item - outOfTheMonthIndexRangeLeft.upperBound
			return DayViewModel(day: month.days[relativeIndex])
		default:
			fatalError("Index out of scope")
		}
	}

	open func numberOfViewDays() -> Int {
		return month.numberOfDays
			+ month.whiteDaysAfterFirstDayOfTheMonth
			+ month.whiteDaysBeforeEndDayOfTheMonth
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

extension MonthViewModel {
	public var outOfTheMonthIndexRangeLeft: Range<Int> {
		let lowerBound = Int.min
		let upperBound = month.whiteDaysAfterFirstDayOfTheMonth
		return lowerBound..<upperBound
	}

	public var inTheMonthIndexRange: Range<Int> {
		let lowerBound = outOfTheMonthIndexRangeLeft.upperBound
		let upperBound = lowerBound + month.numberOfDays
		return lowerBound..<upperBound
	}

	public var outOfTheMonthIndexRangeRight: Range<Int> {
		let lowerBound = inTheMonthIndexRange.upperBound
		let upperBound = Int.max
		return lowerBound..<upperBound
	}
}
