//
//  CalendarView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class CalendarView: UIView {
	fileprivate enum Constants {
		static var headerHeight: CGFloat = 44
	}

	fileprivate var stackView: UIStackView!
	fileprivate var headerView: HeaderView!
	fileprivate var collectionView: UICollectionView!
	fileprivate var viewModel: CalendarViewModel!

	public override init(frame: CGRect) {
		super.init(frame: frame)
		collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
		stackView = UIStackView(frame: frame)
		headerView = HeaderView(frame: frame)

		setUpCollectionView()
		setUpStackView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		collectionView = UICollectionView(coder: aDecoder)!
		stackView = UIStackView(coder: aDecoder)
		headerView = HeaderView(coder: aDecoder)!

		setUpCollectionView()
	}
}

// MARK: Public methods

extension CalendarView {
	open func set(mode: Mode, animated: Bool = true) {
		viewModel.set(mode: mode)
		collectionView.setCollectionViewLayout(viewModel.layout, animated: animated)
	}

	open func load(with viewModel: CalendarViewModel, animated: Bool = true) {
		self.headerView.load(with: viewModel.veryShortWeekdaySymbols)

		self.viewModel = viewModel
		self.viewModel.view = self

		collectionView.setCollectionViewLayout(viewModel.layout, animated: animated)
		collectionView.delegate = self
		collectionView.dataSource = self
	
		collectionView.reloadData()
	}

	open func reloadData() {
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

		headerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight).isActive = true

		stackView.addArrangedSubview(headerView)
		stackView.addArrangedSubview(collectionView)
	}

	func setUpCollectionView() {
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(MonthView.self)
		collectionView.backgroundColor = .white
	}
}

// MARK: UICollectionViewDataSource methods

extension CalendarView: UICollectionViewDataSource {
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfMonths
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cell: MonthView.self, at: indexPath)

		let monthViewModel = viewModel.monthViewModel(at: indexPath)
		cell.load(with: monthViewModel, animated: false)

		return cell
	}
}

// MARK: UICollectionViewDelegate methods

extension CalendarView: UICollectionViewDelegate {

}

// MARK: UIScrollViewDelegate methods

extension CalendarView {
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		viewModel.scrollViewDidScroll(scrollView)
	}
}
