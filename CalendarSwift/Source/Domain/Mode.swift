//
//  Mode.swift
//  CalendarSwift
//
//  Created by Jose Maria Puerta on 21/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public enum Mode {
	case monthly
	case weekly
}

extension Mode {
	func monthLayout(viewModel: MonthViewModel) -> MonthViewLayout {
		switch self {
		case .monthly:
			return MonthlyMonthViewLayout(viewModel: viewModel)
		case .weekly:
			return WeeklyMonthViewLayout(viewModel: viewModel)
		}
	}

	func calendarLayout(viewModel: CalendarViewModel) -> CalendarViewLayout {
		switch self {
		case .monthly:
			return MonthlyCalendarViewLayout(viewModel: viewModel)
		case .weekly:
			return WeeklyCalendarViewLayout(viewModel: viewModel)
		}
	}
}
