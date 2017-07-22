//
//  WeeklyMonthViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class WeeklyMonthViewLayout: MonthViewLayout {
	override public func setUp() {
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = .horizontal
		sectionInset = .zero
	}

	public override func prepare() {
		super.prepare()
		guard let collectionView = collectionView else { return }

		let bounds = collectionView.bounds

		let itemsPerRow = CGFloat(viewModel.numberOfWeekdays)
		let width = bounds.width / itemsPerRow

		itemSize = CGSize(width: width, height: bounds.height)
	}


	public override var numberOfViewDays: Int {
		return viewModel.numberOfDays
	}

	public override func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		let day = viewModel.day(at: indexPath)
		return DayViewModel(day: day)
	}
}
