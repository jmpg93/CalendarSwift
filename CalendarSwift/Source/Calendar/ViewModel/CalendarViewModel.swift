//
//  CalendarViewModel.swift
//  CalendarSwift
//
//  Created by Jose Maria Puerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import TimeSwift

public class CalendarViewModel  {
	weak var view: CalendarView?
	fileprivate var years: [Year] = []
	fileprivate var mode: Mode

	public init(years: [Year], mode: Mode) {
		self.years = years
		self.mode = mode
	}

	public convenience init(year: Year, mode: Mode) {
		self.init(years: [year], mode: mode)
	}

	fileprivate var months: [Month] {
		return years.flatMap({ $0.months })
	}

	public var weekdaySymbols: [String] {
		return months.first?.weekdaySymbols ?? []
	}

	public var veryShortWeekdaySymbols: [String] {
		return months.first?.veryShorWeekdaySymbols ?? []
	}

	public var layout: UICollectionViewLayout {
		return mode.calendarLayout(viewModel: self)
	}

	public func set(mode: Mode) {
		self.mode = mode
	}
}

// MARK: DataSource method

extension CalendarViewModel {
	public var numberOfMonths: Int {
		return months.count
	}

	public func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return MonthViewModel(month: months[indexPath.item], mode: mode)
	}
}
