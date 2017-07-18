//
//  MonthViewModel.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import TimeSwift

public class MonthViewModel {
	fileprivate let month: Month
	fileprivate let layout: MonthViewLayout

	//TODO: Change
	public init(month: Month, layout: MonthViewLayout = MonthlyMonthViewLayout()) {
		self.month = month
		self.layout = layout
	}

	var symbol: String {
		return month.symbol
	}

	var numberOfWeeks: Int {
		return month.numberOfWeeks
	}

	var numberOfDays: Int {
		return month.numberOfDays
	}

	var numberOfWeekdays: Int {
		return month.numberOfWeekdays
	}
}

// MARK: Datasource methods

extension MonthViewModel {
	public func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		switch indexPath.item {
		case outOfTheMonthIndexRangeLeft:
			return EmptyDayViewModel()
		case outOfTheMonthIndexRangeRight:
			return EmptyDayViewModel()
		case inTheMonthIndexRange:
			let relativeIndex = indexPath.item - outOfTheMonthIndexRangeLeft.upperBound
			return DayViewModel(day: month.days[relativeIndex])
		default:
			fatalError("Index out of scope")
		}
	}

	public var numberOfViewDays: Int {
		return month.numberOfDays
			+ month.whiteDaysAfterEndDayOfTheMonth
			+ month.whiteDaysBeforeFirstDayOfTheMonth
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

	func sizeForItem(at indexPath: IndexPath, in bounds: CGRect) -> CGSize {
		return layout.itemSize(at: indexPath, in: bounds, using: self)
	}

	func inset(in bounds: CGRect) -> UIEdgeInsets {
		return layout.inset(in: bounds, using: self)
	}
}

// MARK: Private methods

fileprivate extension MonthViewModel {
	var outOfTheMonthIndexRangeLeft: Range<Int> {
		let lowerBound = Int.min
		let upperBound = month.whiteDaysBeforeFirstDayOfTheMonth
		return lowerBound..<upperBound
	}

	var inTheMonthIndexRange: Range<Int> {
		let lowerBound = outOfTheMonthIndexRangeLeft.upperBound
		let upperBound = lowerBound + month.numberOfDays
		return lowerBound..<upperBound
	}

	var outOfTheMonthIndexRangeRight: Range<Int> {
		let lowerBound = inTheMonthIndexRange.upperBound
		let upperBound = Int.max
		return lowerBound..<upperBound
	}
}

extension Month {
	public var whiteDaysBeforeFirstDayOfTheMonth: Int {
		return firstDayOfTheMonthDay.weekday.advanced(by: -1)
	}

	public var whiteDaysAfterEndDayOfTheMonth: Int {
		return numberOfWeekdays - lastDayOfTheMonthDay.weekday
	}
}
