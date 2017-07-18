//
//  CalendarViewModel.swift
//  CalendarSwift
//
//  Created by Jose Maria Puerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import TimeSwift

public struct CalendarViewModel {
	fileprivate let calendar: Calendar
	fileprivate let startDate: Date

	fileprivate var months: [Month] = []
	fileprivate var currentMonth: Month

	public init(calendar: Calendar = .current, startDate: Date) {
		self.calendar = calendar
		self.startDate = startDate

		self.currentMonth = Month(date: startDate, in: calendar)
		self.months = currentMonth.year.months
	}
}


// MARK: DataSource method

extension CalendarViewModel {
	func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return MonthViewModel(month: months[indexPath.item])
	}

	func numberOfMonths() -> Int {
		return months.count
	}
}

// MARK: Layout method

extension CalendarViewModel {
	var minimumLineSpacing: CGFloat {
		return 0
	}

	var minimumInteritemSpacing: CGFloat {
		return 0
	}

	func sizeForItem(at indexPath: IndexPath, in bounds: CGRect) -> CGSize {
		let month = months[indexPath.item]

		let days = (month.numberOfDays + month.whiteDaysAfterEndDayOfTheMonth + month.whiteDaysBeforeFirstDayOfTheMonth)
		let weeks = days / month.numberOfWeekdays
		let width = bounds.width
		let height = (width / CGFloat(month.numberOfWeekdays)) * CGFloat(weeks)

		assert(days % month.numberOfWeekdays == 0)

		print(month.symbol)
		print("White before", month.whiteDaysBeforeFirstDayOfTheMonth)
		print("White afer", month.whiteDaysAfterEndDayOfTheMonth)
		print("Real days", month.numberOfDays)
		print("Visual days", days)
		print("Weekdays", month.numberOfWeekdays)
		print("Weeks", days / month.numberOfWeekdays)
		print("Size", CGSize(width: width, height: height))
		print(" ")

		return CGSize(width: width, height: height)
	}

	func inset(in bounds: CGRect) -> UIEdgeInsets {
		return .zero
	}
}

// MARK: Private method

fileprivate extension CalendarViewModel {

}
