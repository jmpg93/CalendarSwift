//
//  MonthlyCalendarLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class MonthlyCalendarViewLayout: UICollectionViewFlowLayout {
	fileprivate let viewModel: CalendarViewModel

	public init(viewModel: CalendarViewModel) {
		self.viewModel = viewModel
		super.init()
		setUp()
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setUp() {
		minimumLineSpacing = 0
		minimumLineSpacing = 0
		scrollDirection = .vertical
		sectionInset = .zero
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

fileprivate extension MonthlyCalendarViewLayout {
	func itemSize(at indexPath: IndexPath, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGSize {
		let month = viewModel.monthViewModel(at: indexPath)

		let days = month.numberOfViewDays
		let weeks = days / month.numberOfWeekdays
		let width = bounds.width
		let height = (width / CGFloat(month.numberOfWeekdays)) * CGFloat(weeks)

		assert(days % month.numberOfWeekdays == 0)

		return CGSize(width: width, height: height)
	}
}
