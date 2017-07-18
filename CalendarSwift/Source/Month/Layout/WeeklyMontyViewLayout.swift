//
//  WeeklyMontyViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class WeeklyMonthlyViewLayout: MonthViewLayout {
	public var minimumInteritemSpacing: CGFloat {
		return 0
	}

	public var minimumLineSpacing: CGFloat {
		return 0
	}

	public var scrollDirection: UICollectionViewScrollDirection {
		return .horizontal
	}

	public func inset(in bounds: CGRect, using model: MonthViewModel) -> UIEdgeInsets {
		return .zero
	}

	public func itemSize(at indexPath: IndexPath, in bounds: CGRect, using model: MonthViewModel) -> CGSize {
		let itemsPerRow = CGFloat(model.numberOfWeekdays)
		let width = bounds.width / itemsPerRow
		return CGSize(width: width, height: bounds.height)
	}
}

