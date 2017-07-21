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
	fileprivate var months: [Month] {
		return years.flatMap({ $0.months })
	}

	public init(years: [Year], mode: Mode) {
		self.years = years
		self.mode = mode
	}

	public convenience init(year: Year, mode: Mode) {
		self.init(years: [year], mode: mode)
	}

	var weekdaySymbols: [String] {
		return months.first?.weekdaySymbols ?? []
	}

	var veryShortWeekdaySymbols: [String] {
		return months.first?.veryShorWeekdaySymbols ?? []
	}
}


// MARK: DataSource method

extension CalendarViewModel {
	var numberOfMonths: Int {
		return months.count
	}

	func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return MonthViewModel(month: months[indexPath.item], mode: mode)
	}
}
