//
//  WeeklyMonthViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class WeeklyMonthViewLayout: MonthViewLayout {
	public init() { }
	
	public func dayViewModel(at indexPath: IndexPath, in viewModel: MonthViewModel) -> DayViewModelProtocol {
		return DayViewModel(day: viewModel.day(at: indexPath))
	}

	public func numberOfDays(in month: MonthViewModel) -> Int {
		return month.numberOfDays
	}

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
		//TODO: Avoid main screen
		let width = UIScreen.main.bounds.width / itemsPerRow
		return CGSize(width: width, height: bounds.height)
	}
}

