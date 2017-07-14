//
//  Week.swift
//  TimeSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 jmpg93. All rights reserved.
//

import Foundation

struct Week: Comparable {
	static let current = Week(date: Date())

	fileprivate let referenceDate: Date
	fileprivate let calendar: Calendar

	init(date: Date, in calendar: Calendar = .current) {
		self.referenceDate = date
		self.calendar = calendar
	}

	// Basic

	var weekOfMonth: Int {
		return calendar.dateComponents([.weekOfMonth], from: referenceDate).weekOfMonth!
	}

	var weekOfYear: Int {
		return calendar.dateComponents([.weekOfYear], from: referenceDate).weekOfYear!
	}

	var isCurrentWeek: Bool {
		return Week.current.weekOfYear == weekOfYear || month.isCurrentMonth || year.isCurrentYear
	}

	var numberOfWeekdays: Int {
		return calendar.range(of: .weekday, in: .month, for: referenceDate)!.count
	}

	// Jumps

	var month: Month {
		return Month(date: referenceDate, in: calendar)
	}

	var year: Year {
		return Year(date: referenceDate, in: calendar)
	}

	// Comparable

	static func <(lhs: Week, rhs: Week) -> Bool {
		return lhs.referenceDate < rhs.referenceDate
	}

	static func ==(lhs: Week, rhs: Week) -> Bool {
		return lhs.referenceDate == rhs.referenceDate
	}
}
