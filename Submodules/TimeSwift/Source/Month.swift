//
//  Month.swift
//  TimeSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 jmpg93. All rights reserved.
//

import Foundation


struct Month: Comparable {
	static let current: Month = Month(date: Date())

	fileprivate let referenceDate: Date
	fileprivate let calendar: Calendar

	init(date: Date, in calendar: Calendar = .current) {
		self.referenceDate = date
		self.calendar = calendar
	}

	// Symbols

	var symbol: String {
		return calendar.monthSymbols[month-1]
	}

	var shortSymbol: String {
		return calendar.shortMonthSymbols[month-1]
	}

	var veryShortSymbol: String {
		return calendar.veryShortMonthSymbols[month-1]
	}

	// Basic

	var month: Int {
		return calendar.dateComponents([.month], from: referenceDate).month!
	}

	var isCurrentMonth: Bool {
		return Month.current.month == month || year.isCurrentYear
	}

	var isLeapMonth: Bool {
		return calendar.dateComponents([.year, .month], from: referenceDate).isLeapMonth!
	}

	// Weeks

	var numberOfWeeks: Int {
		return calendar.range(of: .weekOfMonth, in: .month, for: referenceDate)!.count
	}

	// Days

	var numberOfDays: Int {
		return calendar.range(of: .day, in: .month, for: referenceDate)!.count
	}

	var firstDayOfTheMonthDate: Date {
		let components = calendar.dateComponents([.year, .month], from: referenceDate)
		return calendar.date(from: components)!
	}

	var firstDayOfTheMonthDay: Day {
		return Day(date: firstDayOfTheMonthDate)
	}

	var lastDayOfTheMonthDate: Date {
		return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfTheMonthDate)!
	}

	var lastDayOfTheMonthDay: Day {
		return Day(date: lastDayOfTheMonthDate)
	}

	// White days

	var whiteDaysAfterFirstDayOfTheMonth: Int {
		return firstDayOfTheMonthDay.weekday.advanced(by: -1)
	}

	var whiteDaysBeforeEndDayOfTheMonth: Int {
		let anyWeek = Week(date: referenceDate, in: calendar)
		return anyWeek.numberOfWeekdays - lastDayOfTheMonthDay.weekday
	}

	// Jumps

	var year: Year {
		return Year(date: referenceDate, in: calendar)
	}

	// Jumps inverse

	var days: [Day] {
		var day = firstDayOfTheMonthDay
		var days: [Day] = []

		while day <= lastDayOfTheMonthDay {
			days.append(day)
			day = day.next
		}

		return days
	}

	// Movement

	func month(byAddingMonth value: Int) -> Month {
		let date = calendar.date(byAdding: .month, value: value, to: referenceDate)!
		return Month(date: date, in: calendar)
	}

	var next: Month {
		return month(byAddingMonth: 1)
	}

	var previous: Month {
		return month(byAddingMonth: -1)
	}

	// Comparable

	static func <(lhs: Month, rhs: Month) -> Bool {
		return lhs.referenceDate < rhs.referenceDate
	}

	static func ==(lhs: Month, rhs: Month) -> Bool {
		return lhs.referenceDate == rhs.referenceDate
	}
}
