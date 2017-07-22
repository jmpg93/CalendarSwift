//
//  MonthlyMonthLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class MonthlyMonthViewLayout: MonthViewLayout {
	override public func setUp() {
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = .vertical
		sectionInset = .zero
	}

	public override func prepare() {
		super.prepare()
		guard let collectionView = collectionView else { return }

		let bounds = collectionView.bounds

		let itemsPerRow = CGFloat(viewModel.numberOfWeekdays)
		let width = (bounds.width / itemsPerRow)

		itemSize = CGSize(width: width, height: width)
	}

	override public var numberOfViewDays: Int {
		return viewModel.numberOfDays
			+ viewModel.whiteDaysAfterEndDayOfTheMonth
			+ viewModel.whiteDaysBeforeFirstDayOfTheMonth
	}
	
	override public func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		switch indexPath.item {
		case viewModel.outOfTheMonthIndexRangeLeft:
			return EmptyDayViewModel()
			
		case viewModel.outOfTheMonthIndexRangeRight:
			return EmptyDayViewModel()

		case viewModel.inTheMonthIndexRange:
			let relativeIndex = IndexPath(item: indexPath.item - viewModel.whiteDaysBeforeFirstDayOfTheMonth,
			                              section: indexPath.section)
			let day = viewModel.day(at: relativeIndex)
			return DayViewModel(day: day)
			
		default:
			fatalError("Index out of scope")
		}
	}
}
