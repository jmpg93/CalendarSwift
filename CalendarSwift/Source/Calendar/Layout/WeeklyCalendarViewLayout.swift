//
//  WeeklyCalendarViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class WeeklyCalendarViewLayout: CalendarViewLayout {
	public override func setUp() {
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = .horizontal
		sectionInset = .zero
		estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
	}

	public override var numberOfMonths: Int {
		return viewModel.numberOfMonths
	}

	public override func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return viewModel.monthViewModel(at: indexPath)
	}

	public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let collectionView = collectionView else {
			return nil
		}

		let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
		attribute.size = itemSize(at: indexPath, in: collectionView.bounds, using: viewModel)

		return attribute
	}
}

fileprivate extension WeeklyCalendarViewLayout {
	func itemSize(at indexPath: IndexPath, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGSize {
		let month = viewModel.monthViewModel(at: indexPath)

		let days = month.numberOfViewDays
		let dayWidth = bounds.width / CGFloat(month.numberOfWeekdays)
		let monthWidth = dayWidth * CGFloat(days)

		return CGSize(width: monthWidth, height: bounds.height)
	}
}
