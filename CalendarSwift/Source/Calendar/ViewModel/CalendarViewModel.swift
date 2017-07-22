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

	fileprivate let timeLoader = TimeLoader()
	
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

public extension CalendarViewModel {
	var numberOfMonths: Int {
		return months.count
	}

	func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return MonthViewModel(month: months[indexPath.item], mode: mode)
	}
}

// MARK: Delegate methods

public extension CalendarViewModel {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		timeLoader.scrollViewDidScroll(scrollView: scrollView, currentYears: years)
	}
}
