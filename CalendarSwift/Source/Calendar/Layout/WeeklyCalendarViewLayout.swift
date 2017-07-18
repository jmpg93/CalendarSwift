//
//  WeeklyCalendarViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class WeeklyCalendarViewLayout: CalendarViewLayout {
	public var minimumInteritemSpacing: CGFloat {
		return 0
	}

	public var minimumLineSpacing: CGFloat {
		return 0
	}

	public var scrollDirection: UICollectionViewScrollDirection {
		return .horizontal
	}

	public func inset(in bounds: CGRect, using model: CalendarViewModel) -> UIEdgeInsets {
		return .zero
	}

	public func itemSize(at indexPath: IndexPath, in bounds: CGRect, using model: CalendarViewModel) -> CGSize {
		let month = model.monthViewModel(at: indexPath)

		let days = month.numberOfViewDays
		let dayWidth = bounds.width / CGFloat(month.numberOfWeekdays)
		let monthWidth = dayWidth * CGFloat(days)

		return CGSize(width: monthWidth, height: bounds.height)
	}
}

