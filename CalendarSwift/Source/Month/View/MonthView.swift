//
//  MonthView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class MonthView: UIView {
	@IBOutlet weak var collectionView: UICollectionView!
	fileprivate var viewModel: MonthViewModel!

	open override func awakeFromNib() {
		super.awakeFromNib()
		registerCells()
	}
}

// MARK: Public methods

extension MonthView {
	open class func instanceFromNib() -> MonthView {
		return MonthView.nib.instantiate()
	}

	open func load(with viewModel: MonthViewModel) {
		self.viewModel = viewModel
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
	}
}

// MARK: Private methods

private extension MonthView {
	func registerCells() {
		collectionView.register(DayView.nib,
		                        forCellWithReuseIdentifier: DayView.identifier)
	}
}

// MARK: UICollectionDataSource methods

extension MonthView: UICollectionViewDataSource {
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cell: DayView.self, at: indexPath)

		let dayViewModel = viewModel.dayViewModel(at: indexPath)
		cell.setUp(with: dayViewModel)
		
		return cell
	}

	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfViewDays()
	}
}

// MARK: UICollectionViewDelegate methods

extension MonthView: UICollectionViewDelegate {

}
