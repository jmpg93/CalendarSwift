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
	func numberOfYears() -> Int {
		return years.count
	}

	func numberOfMonths(in year: Int) -> Int {
		return years[year].months.count
	}

	func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		let month = years[indexPath.section].months[indexPath.item]
		return MonthViewModel(month: month, mode: mode)
	}
}

// MARK: Delegate methods

public extension CalendarViewModel {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let loaderResult = timeLoader.scrollViewDidScroll(scrollView: scrollView, currentYears: years)
		switch loaderResult {
		case .none:
			return
		case .inserted(let newYears, let insertIndexPaths, let sections):
			self.years += newYears
			self.view?.insertMonths(indexPaths: insertIndexPaths, sections: sections)
		}
	}
}
