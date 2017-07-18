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
	fileprivate var months: [Month] = []
	fileprivate var layout: CalendarViewLayout

	public init(months: [Month], layout: CalendarViewLayout = MonthlyCalendarViewLayout()) {
		self.months = months
		self.layout = layout
	}

	public convenience init(years: [Year], layout: CalendarViewLayout) {
		self.init(months: years.flatMap({ $0.months }), layout: layout)
	}

	public convenience init(year: Year, layout: CalendarViewLayout) {
		self.init(months: year.months, layout: layout)
	}
}


// MARK: DataSource method

extension CalendarViewModel {
	public func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return MonthViewModel(month: months[indexPath.item])
	}

	func numberOfMonths() -> Int {
		return months.count
	}
}

// MARK: Layout method

extension CalendarViewModel {
	var minimumLineSpacing: CGFloat {
		return layout.minimumLineSpacing
	}

	var minimumInteritemSpacing: CGFloat {
		return layout.minimumInteritemSpacing
	}

	func sizeForItem(at indexPath: IndexPath, in bounds: CGRect) -> CGSize {
		return layout.itemSize(at: indexPath, in: bounds, using: self)
	}

	func inset(in bounds: CGRect) -> UIEdgeInsets {
		return layout.inset(in: bounds, using: self)
	}
}

// MARK: Private method

fileprivate extension CalendarViewModel {

}
