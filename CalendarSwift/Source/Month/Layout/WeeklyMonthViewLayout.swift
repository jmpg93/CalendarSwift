//
//  WeeklyMonthViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

public class WeeklyMonthViewLayout: UICollectionViewFlowLayout {
	fileprivate let viewModel: MonthViewModel

	public init(viewModel: MonthViewModel) {
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
		scrollDirection = .horizontal
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

fileprivate extension WeeklyMonthViewLayout {
	func itemSize(at indexPath: IndexPath, in bounds: CGRect, using viewModel: MonthViewModel) -> CGSize {
		let itemsPerRow = CGFloat(viewModel.numberOfWeekdays)
		let width = bounds.width / itemsPerRow
		return CGSize(width: width, height: bounds.height)
	}
}
