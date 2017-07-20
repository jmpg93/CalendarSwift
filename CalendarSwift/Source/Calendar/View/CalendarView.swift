//
//  CalendarView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class CalendarView: UIView {
	fileprivate var stackView: UIStackView!
	fileprivate var headerView: CalendarHeaderView!
	fileprivate var collectionView: FlowDirectionableCollectionView!
	fileprivate var viewModel: CalendarViewModel!

	public override init(frame: CGRect) {
		super.init(frame: frame)
		collectionView = FlowDirectionableCollectionView(frame: frame)
		stackView = UIStackView(frame: frame)
		headerView = CalendarHeaderView(frame: frame)

		setUpCollectionView()
		setUpStackView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		collectionView = FlowDirectionableCollectionView(coder: aDecoder)!
		stackView = UIStackView(coder: aDecoder)
		headerView = CalendarHeaderView(coder: aDecoder)!

		setUpCollectionView()
	}
}

// MARK: Public methods

extension CalendarView {
	open func load(with viewModel: CalendarViewModel) {
		self.headerView.load(with: viewModel.veryShortWeekdaySymbols)

		self.viewModel = viewModel

		collectionView.flowDelegate = self
		collectionView.dataSource = self
	
		collectionView.reloadData()
	}
}

// MARK: Private methods

fileprivate extension CalendarView {
	func setUpStackView() {
		stackView.constraintToBounds(of: self)
		stackView.alignment = .fill
		stackView.axis = .vertical
		stackView.distribution = .fill

		headerView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		headerView.heightAnchor.constraint(equalToConstant: 44).isActive = true

		stackView.addArrangedSubview(headerView)
		stackView.addArrangedSubview(collectionView)
	}

	func setUpCollectionView() {
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

extension CalendarView: UICollectionViewDelegateFlowDirection {
	var scrollDirection: UICollectionViewScrollDirection {
		return viewModel.scrollDirection
	}

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
