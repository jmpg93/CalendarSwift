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
	weak var view: MonthView?
	fileprivate let month: Month
	fileprivate var mode: Mode

	public init(month: Month, mode: Mode) {
		self.month = month
		self.mode = mode
	}

	public var symbol: String {
		return month.symbol
	}

	public var shortSymbol: String {
		return month.shortSymbol
	}

	public var numberOfWeeks: Int {
		return month.numberOfWeeks
	}

	public var numberOfDays: Int {
		return month.numberOfDays
	}

	public var numberOfWeekdays: Int {
		return month.numberOfWeekdays
	}

	public var firstDayOfTheMonthWeekday: Int {
		return month.firstDayOfTheMonthDay.weekday
	}

	public var whiteDaysBeforeFirstDayOfTheMonth: Int {
		return month.firstDayOfTheMonthDay.weekday.advanced(by: -1)
	}

	public var whiteDaysAfterEndDayOfTheMonth: Int {
		return month.numberOfWeekdays - month.lastDayOfTheMonthDay.weekday
	}

	public var weekdaySymbols: [String] {
		return month.weekdaySymbols
	}

	public var veryShortWeekdaySymbols: [String] {
		return month.veryShorWeekdaySymbols
	}

	public var isHeaderEnabled: Bool {
		return mode == .monthly
	}

	public var headerHeight: CGFloat {
		return mode == .monthly ? 40.0 : 0.0
	}

	public var headerSymbols: [String] {
		var models = [String].init(repeating: " ", count: numberOfWeekdays)
		models[firstDayOfTheMonthWeekday-1] = shortSymbol
		return models
	}

	public var outOfTheMonthIndexRangeLeft: Range<Int> {
		let lowerBound = Int.min
		let upperBound = whiteDaysBeforeFirstDayOfTheMonth
		return lowerBound..<upperBound
	}

	public var inTheMonthIndexRange: Range<Int> {
		let lowerBound = outOfTheMonthIndexRangeLeft.upperBound
		let upperBound = lowerBound + numberOfDays
		return lowerBound..<upperBound
	}

	public var outOfTheMonthIndexRangeRight: Range<Int> {
		let lowerBound = inTheMonthIndexRange.upperBound
		let upperBound = Int.max
		return lowerBound..<upperBound
	}

	public lazy var layout: MonthViewLayout = {
		return self.mode.monthLayout(viewModel: self)
	}()
}

// MARK: Datasource methods

extension MonthViewModel {
	public func day(at indexPath: IndexPath) -> Day {
		return month.days[indexPath.item]
	}

	public func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		return layout.dayViewModel(at: indexPath)
	}

	public var numberOfViewDays: Int {
		return layout.numberOfViewDays
	}
}

// MARK: Layout methods

extension MonthViewModel {
	public var collectionViewLayout: UICollectionViewLayout {
		switch mode {
		case .monthly:
			return MonthlyMonthViewLayout(viewModel: self)
		case .weekly:
			return WeeklyMonthViewLayout(viewModel: self)
		}
	}
}
