//
//  CalendarView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class CalendarView: UIView {
	fileprivate var collectionView: UICollectionView!
	fileprivate var viewModel: CalendarViewModel!

	public override init(frame: CGRect) {
		super.init(frame: frame)
		let layout = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
		setUpCollectionView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		collectionView = UICollectionView(coder: aDecoder)
		setUpCollectionView()
	}
}

// MARK: Public methods

extension CalendarView {
	open func load(with viewModel: CalendarViewModel) {
		self.viewModel = viewModel
		collectionView.delegate = self
		collectionView.dataSource = self
	}
}

// MARK: Private methods

fileprivate extension CalendarView {
	func setUpCollectionView() {
		collectionView.constraintToBounds(of: self)
		collectionView.register(MonthView.self)
	}
}

// MARK: UICollectionViewDelegate methods

extension CalendarView: UICollectionViewDelegate {

}

// MARK: UICollectionViewDataSource methods

extension CalendarView: UICollectionViewDataSource {
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfMonths()
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cell: MonthView.self, at: indexPath)
		
		let monthViewModel = viewModel.monthViewModel(at: indexPath)
		cell.load(with: monthViewModel)

		return cell
	}
}

// MARK: UICollectionViewDelegateFlowLayout methods

extension CalendarView: UICollectionViewDelegateFlowLayout {
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return viewModel.minimumLineSpacing
	}

	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return viewModel.minimumInteritemSpacing
	}

	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return viewModel.sizeForItem(at: indexPath, in: collectionView.bounds)
	}

	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return viewModel.inset(in: collectionView.bounds)
	}
}
