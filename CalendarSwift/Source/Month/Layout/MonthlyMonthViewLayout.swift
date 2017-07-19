//
//  MonthlyMonthLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class MonthlyMonthViewLayout: MonthViewLayout {
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

	public func dayViewModel(at indexPath: IndexPath, in viewModel: MonthViewModel) -> DayViewModelProtocol {
		switch indexPath.item {
		case outOfTheMonthIndexRangeLeft(in: viewModel):
			return EmptyDayViewModel()
		case outOfTheMonthIndexRangeRight(in: viewModel):
			return EmptyDayViewModel()
		case inTheMonthIndexRange(in: viewModel):
			let relativeIndex = IndexPath(item: indexPath.item - outOfTheMonthIndexRangeLeft(in: viewModel).upperBound,
			                    			          section: 0)
			return DayViewModel(day: viewModel.day(at: relativeIndex))
		default:
			fatalError("Index out of scope")
		}
	}

	public func numberOfDays(in viewModel: MonthViewModel) -> Int {
		return viewModel.numberOfDays
		+ viewModel.whiteDaysAfterEndDayOfTheMonth
		+ viewModel.whiteDaysBeforeFirstDayOfTheMonth
	}

	public func inset(in bounds: CGRect, using viewModel: MonthViewModel) -> UIEdgeInsets {
		return .zero
	}

	public func itemSize(at indexPath: IndexPath, in bounds: CGRect, using viewModel: MonthViewModel) -> CGSize {
		let itemsPerRow = CGFloat(viewModel.numberOfWeekdays)
		let width = bounds.width / itemsPerRow
		return CGSize(width: width, height: width)
	}
}

extension MonthlyMonthViewLayout {
	func outOfTheMonthIndexRangeLeft(in viewModel: MonthViewModel) -> Range<Int> {
		let lowerBound = Int.min
		let upperBound = viewModel.whiteDaysBeforeFirstDayOfTheMonth
		return lowerBound..<upperBound
	}

	func inTheMonthIndexRange(in viewModel: MonthViewModel) -> Range<Int> {
		let lowerBound = outOfTheMonthIndexRangeLeft(in: viewModel).upperBound
		let upperBound = lowerBound + viewModel.numberOfDays
		return lowerBound..<upperBound
	}

	func outOfTheMonthIndexRangeRight(in viewModel: MonthViewModel) -> Range<Int> {
		let lowerBound = inTheMonthIndexRange(in: viewModel).upperBound
		let upperBound = Int.max
		return lowerBound..<upperBound
	}
}
