//
//  MonthViewModel.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import TimeSwift

open class MonthViewModel: NSObject {
	fileprivate let month: Month

	public init(month: Month) {
		self.month = month
	}
}

// MARK: Public methods

extension MonthViewModel {
	open func dayViewModel(at indexPath: IndexPath) -> DayViewModel {
		return DayViewModel(day: month.days[indexPath.item])
	}

	open func numberOfViewDays() -> Int {
		return month.numberOfDays
	}
}

// MARK: Private methods

private extension MonthViewModel {

}
