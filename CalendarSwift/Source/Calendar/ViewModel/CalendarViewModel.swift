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
		return MonthViewModel(month: months[indexPath.row])
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
		let width = min(bounds.width, bounds.height)
		return CGSize(width: width, height: width)
	}

	func inset(in bounds: CGRect) -> UIEdgeInsets {
		return .zero
	}
}

// MARK: Private method

fileprivate extension CalendarViewModel {

}
