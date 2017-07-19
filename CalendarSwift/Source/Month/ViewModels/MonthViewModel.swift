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

	var whiteDaysBeforeFirstDayOfTheMonth: Int {
		return month.firstDayOfTheMonthDay.weekday.advanced(by: -1)
	}

	public var whiteDaysAfterEndDayOfTheMonth: Int {
		return month.numberOfWeekdays - month.lastDayOfTheMonthDay.weekday
	}
}

// MARK: Datasource methods

extension MonthViewModel {
	public func day(at indexPath: IndexPath) -> Day {
		return month.days[indexPath.item]
	}

	public func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		return layout.dayViewModel(at: indexPath, in: self)
	}

	public var numberOfViewDays: Int {
		return layout.numberOfDays(in: self)
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

	var scrollDirection: UICollectionViewScrollDirection {
		return layout.scrollDirection
	}

	func sizeForItem(at indexPath: IndexPath, in bounds: CGRect) -> CGSize {
		return layout.itemSize(at: indexPath, in: bounds, using: self)
	}

	func inset(in bounds: CGRect) -> UIEdgeInsets {
		return layout.inset(in: bounds, using: self)
	}
}

// MARK: Private methods
