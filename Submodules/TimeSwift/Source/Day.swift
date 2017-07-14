//
//  Day.swift
//  TimeSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 jmpg93. All rights reserved.
//

import Foundation


struct Day: Comparable {
	static let current = Day(date: Date())

	fileprivate let referenceDate: Date
	fileprivate let calendar: Calendar

	init(date: Date, in calendar: Calendar = .current) {
		self.referenceDate = date
		self.calendar = calendar
	}

	// Symbols

	var symbol: String {
		return calendar.weekdaySymbols[weekday]
	}

	var shortSymbol: String {
		return calendar.shortWeekdaySymbols[weekday]
	}

	var veryShortSymbol: String {
		return calendar.veryShortWeekdaySymbols[weekday]
	}

	// Basic

	var day: Int {
		return calendar.dateComponents([.day], from: referenceDate).day!
	}

	var weekday: Int {
		return calendar.dateComponents([.weekday], from: referenceDate).weekday!.advanced(by: -1)
	}

	var yearday: Int {
		return calendar.ordinality(of: .day, in: .year, for: referenceDate)!
	}

	var isCurrentDay: Bool {
		return Day.current.day == day && month.isCurrentMonth && year.isCurrentYear
	}

	var isWeekend: Bool {
		return calendar.isDateInWeekend(referenceDate)
	}

	// Jumps

	var month: Month {
		return Month(date: referenceDate, in: calendar)
	}

	var year: Year {
		return Year(date: referenceDate, in: calendar)
	}

	var week: Week {
		return Week(date: referenceDate, in: calendar)
	}

	// Movement

	func day(byAddingDays value: Int) -> Day {
		let date = calendar.date(byAdding: .day, value: value, to: referenceDate)!
		return Day(date: date, in: calendar)
	}

	var next: Day {
		return day(byAddingDays: 1)
	}

	var previous: Day {
		return day(byAddingDays: -1)
	}

	// Comparable

	public static func <(lhs: Day, rhs: Day) -> Bool {
		return lhs.referenceDate < rhs.referenceDate
	}

	public static func ==(lhs: Day, rhs: Day) -> Bool {
		return lhs.referenceDate == rhs.referenceDate
	}
}
