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
	fileprivate let timeLoader: TimeLoader
	
	public init(years: [Year], mode: Mode) {
		self.years = years
		self.mode = mode

		timeLoader = TimeLoader()
		timeLoader.delegate = self
	}

	public convenience init(year: Year, mode: Mode) {
		self.init(years: [year], mode: mode)
	}

	public var weekdaySymbols: [String] {
		return years.first?.weekDaySymbols ?? []
	}

	public var veryShortWeekdaySymbols: [String] {
		return years.first?.veryShortWeekdaySymbols ?? []
	}

	public var layout: UICollectionViewLayout {
		return mode.calendarLayout(viewModel: self)
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
		timeLoader.scrollViewDidScroll(scrollView: scrollView, currentYears: years)
	}
}

// MARK: TimeLoaderDelegate methods

extension CalendarViewModel: TimeLoaderDelegate {
	var visibleMonths: [MonthViewModel] {
		return view?.indexPathsForVisibleItems.map(monthViewModel) ?? []
	}

	func timeLoaderDidCreateTime(currentYears: [Year], createdYears: [Year], newIndexPaths: [IndexPath], newSections: IndexSet) {
		self.years += createdYears
		self.view?.insertMonths(indexPaths: newIndexPaths, sections: newSections)
	}

	func timeLoadedDidMove(from oldYear: Year, to newYear: Year) {
		guard let view = view else { return }
		view.calendarView(view, didMoveFrom: oldYear.year, to: newYear.year)
	}
}

// MARK: Internal methods

extension CalendarViewModel {
	func set(mode: Mode) {
		self.mode = mode
	}
}
