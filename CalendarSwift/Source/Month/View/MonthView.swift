//
//  MonthView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class MonthView: UICollectionViewCell {
	fileprivate var collectionView: UICollectionView!
	fileprivate var viewModel: MonthViewModel!

	public override init(frame: CGRect) {
		super.init(frame: frame)
		collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
		setUpCollectionView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		collectionView = UICollectionView(coder: aDecoder)
		setUpCollectionView()
	}
}

// MARK: Public methods

extension MonthView {
	open func load(with viewModel: MonthViewModel) {
		self.viewModel = viewModel
		self.collectionView.delegate = self
		self.collectionView.dataSource = self

		self.collectionView.reloadData()
	}
}

// MARK: Private methods

private extension MonthView {
	func setUpCollectionView() {
		collectionView.constraintToBounds(of: self)
		collectionView.register(DayView.self)
		collectionView.backgroundColor = .blue
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

// MARK: UICollectionViewDelegateFlowLayout methods

extension MonthView: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return viewModel.minimumLineSpacing
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return viewModel.minimumInteritemSpacing
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return viewModel.sizeForItem(at: indexPath, in: collectionView.bounds)
	}

	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return viewModel.inset(in: collectionView.bounds)
	}
}
