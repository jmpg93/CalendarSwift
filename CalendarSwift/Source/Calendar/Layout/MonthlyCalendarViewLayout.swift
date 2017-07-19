//
//  MonthlyCalendarLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class MonthlyCalendarViewLayout: CalendarViewLayout {
	public init() { }

	public var minimumInteritemSpacing: CGFloat {
		return 0
	}

	public var minimumLineSpacing: CGFloat {
		return 0
	}

	public var scrollDirection: UICollectionViewScrollDirection {
		return .vertical
	}

	public 	var monthLayout: MonthViewLayout {
		return MonthlyMonthViewLayout()
	}

	public func inset(in bounds: CGRect, using model: CalendarViewModel) -> UIEdgeInsets {
		return .zero
	}

	public func itemSize(at indexPath: IndexPath, in bounds: CGRect, using model: CalendarViewModel) -> CGSize {
		let month = model.monthViewModel(at: indexPath)

		let days = month.numberOfViewDays
		let weeks = days / month.numberOfWeekdays
		let width = bounds.width
		let height = (width / CGFloat(month.numberOfWeekdays)) * CGFloat(weeks)

		assert(days % month.numberOfWeekdays == 0)

		return CGSize(width: width, height: height)
	}
}
