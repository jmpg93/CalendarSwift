//
//  CalendarView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class CalendarView: UIView {
	@IBOutlet weak var collectionView: UICollectionView!
	fileprivate var viewModel: CalendarViewModel!

	override open func awakeFromNib() {
		super.awakeFromNib()
		setUpCollectionView()
	}

	open class func instanceFromNib() -> CalendarView {
		return CalendarView.nib.instantiate()
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
		collectionView.register(CalendarViewCell.nib,
		                        forCellWithReuseIdentifier: CalendarViewCell.identifier)
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

	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		print("Pre")
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarViewCell.identifier, for: indexPath) as! CalendarViewCell
		//let cell = collectionView.dequeue(cell: CalendarViewCell.self, at: indexPath)
		print("Post")

		let monthViewModel = viewModel.monthViewModel(at: indexPath)
		cell.setUp(with: monthViewModel)

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
