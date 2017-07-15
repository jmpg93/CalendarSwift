//
//  CalendarView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

class CalendarView: UIView {
	@IBOutlet weak var collectionView: UICollectionView!
	fileprivate var viewModel: CalendarViewModel!
}

// MARK: UICollectionViewDelegate methods

extension CalendarView: UICollectionViewDelegate {

}

// MARK: UICollectionViewDataSource methods

extension CalendarView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfMonths()
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		fatalError()
	}
}

// MARK: UICollectionViewDelegateFlowLayout methods

extension CalendarView: UICollectionViewDelegateFlowLayout {
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
