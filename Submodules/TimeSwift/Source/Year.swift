//
//  Year.swift
//  TimeSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 jmpg93. All rights reserved.
//

import Foundation


struct Year: Comparable {
	static let current = Year(date: Date())

	fileprivate let referenceDate: Date
	fileprivate let calendar: Calendar

	init(date: Date, in calendar: Calendar = .current) {
		self.referenceDate = date
		self.calendar = calendar
	}

	// Basic

	var year: Int {
		return calendar.component(.year, from: referenceDate)
	}

	var isCurrentYear: Bool {
		return Year.current.year == year
	}

	var isLeapYear: Bool {
		return numberOfDays == 364
	}

	// Days

	var numberOfDays: Int {
		let interval = calendar.dateInterval(of: .year, for: referenceDate)!
		return calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
	}

	// Weeks

	var numberOfWeeks: Int {
		return calendar.range(of: .weekOfYear, in: .year, for: referenceDate)!.count
	}

	// Months

	var firstMonthOfTheYearDate: Date {
		let components = calendar.dateComponents([.year], from: referenceDate)
		return calendar.date(from: components)!
	}

	var firstMonthOfTheYearMonth: Month {
		return Month(date: firstMonthOfTheYearDate, in: calendar)
	}

	var lastMonthOfTheYearDate: Date {
		let components = DateComponents(month: numberOfMonths, day: -1)
		return calendar.date(byAdding: components, to: firstMonthOfTheYearDate)!
	}

	var lastMonthOfTheYearMonth: Month {
		return Month(date: lastMonthOfTheYearDate, in: calendar)
	}

	var numberOfMonths: Int {
		return calendar.range(of: .month, in: .year, for: referenceDate)!.count
	}

	var months: [Month] {
		var month = firstMonthOfTheYearMonth
		var months: [Month] = []

		while month <= lastMonthOfTheYearMonth {
			months.append(month)
			month = month.next
		}

		return months
	}

	// Movement

	func year(byAddingYears value: Int) -> Year {
		let date = calendar.date(byAdding: .year, value: value, to: referenceDate)!
		return Year(date: date, in: calendar)
	}

	var next: Year {
		return year(byAddingYears: 1)
	}

	var previous: Year {
		return year(byAddingYears: -1)
	}

	// Comparable

	static func <(lhs: Year, rhs: Year) -> Bool {
		return lhs.referenceDate < rhs.referenceDate
	}

	static func ==(lhs: Year, rhs: Year) -> Bool {
		return lhs.referenceDate == rhs.referenceDate
	}
}
