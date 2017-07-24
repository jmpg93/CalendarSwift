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

	public lazy var days: [Day] = {
		return self.month.days
	}()

	public lazy var year: Year = {
		return self.month.year
	}()
	
	public lazy var symbol: String = {
		return self.month.symbol
	}()

	public lazy var shortSymbol: String = {
		return self.month.shortSymbol
	}()

	public lazy var numberOfWeeks: Int = {
		return self.month.numberOfWeeks
	}()

	public lazy var numberOfDays: Int = {
		return self.month.numberOfDays
	}()

	public lazy var numberOfWeekdays: Int = {
		return self.month.numberOfWeekdays
	}()

	public lazy var firstDayOfTheMonthWeekday: Int = {
		return self.month.firstDayOfTheMonthDay.weekday
	}()

	public lazy var whiteDaysBeforeFirstDayOfTheMonth: Int = {
		return self.month.firstDayOfTheMonthDay.weekday.advanced(by: -1)
	}()

	public lazy var whiteDaysAfterEndDayOfTheMonth: Int = {
		return self.month.numberOfWeekdays - self.month.lastDayOfTheMonthDay.weekday
	}()

	public lazy var weekdaySymbols: [String] = {
		return self.month.weekdaySymbols
	}()

	public lazy var veryShortWeekdaySymbols: [String] = {
		return self.month.veryShorWeekdaySymbols
	}()

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
		return days[indexPath.item]
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
