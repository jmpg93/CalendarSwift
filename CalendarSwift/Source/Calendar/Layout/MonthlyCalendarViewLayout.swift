//
//  MonthlyCalendarLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class MonthlyCalendarViewLayout: CalendarViewLayout {

	fileprivate var cache = [IndexPath: UICollectionViewLayoutAttributes]()
	fileprivate var lastContentSize: CGSize = .zero

	public override func setUp() {
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		scrollDirection = .vertical
		sectionInset = .zero
		estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
	}

	public func numberOfYears() -> Int {
		return viewModel.numberOfYears()
	}

	public func numberOfMonth(in year: Int) -> Int {
		return viewModel.numberOfMonths(in: year)
	}

	public override func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		return viewModel.monthViewModel(at: indexPath)
	}

	public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var attributes = [UICollectionViewLayoutAttributes]()

		iterateOverPaths { indexPath in
			attributes.append(layoutAttributesForItem(at: indexPath)!)
		}

		return attributes
	}

	public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let collectionView = collectionView else { return nil }
		guard let attribute = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else { return nil }

		guard cache[indexPath] == nil else {
			return cache[indexPath]
		}

		attribute.size = itemSize(at: indexPath, in: collectionView.bounds, using: viewModel)
		attribute.frame = itemFrame(at: indexPath, in: collectionView.bounds, using: viewModel)
		attribute.bounds = itemBounds(at: indexPath, in: collectionView.bounds, using: viewModel)
		cache[indexPath] = attribute

		return attribute
	}

	public override var collectionViewContentSize: CGSize {
		guard let collectionView = collectionView else { return .zero }

		var yOffset: CGFloat = 0.0

		iterateOverPaths { indexPath in
			let size = itemSize(at: indexPath, in: collectionView.bounds, using: viewModel)
			yOffset += size.height
		}

		lastContentSize = CGSize(width: collectionView.bounds.size.width, height: yOffset)
		return CGSize(width: collectionView.bounds.size.width, height: yOffset)
	}

	public override func invalidateLayout() {
		super.invalidateLayout()
		cache.removeAll()
	}
}

fileprivate extension MonthlyCalendarViewLayout {
	func itemSize(at indexPath: IndexPath, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGSize {
		guard cache[indexPath] == nil else {
			return cache[indexPath]!.size
		}

		let month = viewModel.monthViewModel(at: indexPath)

		let days = month.numberOfViewDays
		let weeks = days / month.numberOfWeekdays

		let width = bounds.width
		let height = (width / CGFloat(month.numberOfWeekdays)) * CGFloat(weeks)

		return CGSize(width: width, height: height + month.headerHeight).floored
	}

	func itemFrame(at indexPath: IndexPath, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGRect {
		guard cache[indexPath] == nil else {
			return cache[indexPath]!.frame
		}

		let size = itemSize(at: indexPath, in: bounds, using: viewModel)
		let yOffset = self.yOffset(to: indexPath, in: bounds, using: viewModel)

		let origin = CGPoint(x: 0.0, y: yOffset)

		return CGRect(origin: origin, size: size)
	}

	func itemBounds(at indexPath: IndexPath, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGRect {
		guard cache[indexPath] == nil else {
			return cache[indexPath]!.bounds
		}

		let size = itemSize(at: indexPath, in: bounds, using: viewModel)
		return CGRect(origin: .zero, size: size)
	}

	func iterateOverPaths(_ closure: (IndexPath) -> Void) {
		guard let collectionView = collectionView else { return }

		for section in 0..<collectionView.numberOfSections {
			for item in 0..<collectionView.numberOfItems(inSection: section) {
				let indexPath = IndexPath(item: item, section: section)
				closure(indexPath)
			}
		}
	}

	func yOffset(to indexPath: IndexPath, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGFloat {

		var yOffset: CGFloat = 0.0
		
		for item in 0..<indexPath.item {
			let indexPath = IndexPath(item: item, section: indexPath.section)
			let size = itemSize(at: indexPath, in: bounds, using: viewModel)
			yOffset += size.height
		}

		return yOffset.floored + sectionOffset(at: indexPath.section, in: bounds, using: viewModel)
	}

	func sectionOffset(at section: Int, in bounds: CGRect, using viewModel: CalendarViewModel) -> CGFloat {
		guard let collectionView = collectionView else { return 0.0 }

		var sectionOffset: CGFloat = 0.0

		guard section != 0 else {
			return sectionOffset
		}

		let section = section - 1

		for section in 0...section {
			for item in 0...collectionView.numberOfItems(inSection: section)-1 {
				let indexPath = IndexPath(item: item, section: section)
				let size = itemSize(at: indexPath, in: bounds, using: viewModel)
				sectionOffset += size.height
			}
		}

		return sectionOffset
	}
}
