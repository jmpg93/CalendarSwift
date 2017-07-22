//
//  MonthView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

open class MonthView: UICollectionViewCell {
	fileprivate var stackView: UIStackView!
	fileprivate var headerView: HeaderView!
	fileprivate var collectionView: UICollectionView!
	fileprivate var headerHeightConstraint: NSLayoutConstraint!

	fileprivate var viewModel: MonthViewModel!

	public override init(frame: CGRect) {
		super.init(frame: frame)
		collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
		stackView = UIStackView()
		headerView = HeaderView()
		setUpCollectionView()
		setUpStackView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		collectionView = UICollectionView(coder: aDecoder)
		stackView = UIStackView(coder: aDecoder)
		headerView = HeaderView(coder: aDecoder)
		setUpCollectionView()
		setUpStackView()
	}
}

// MARK: Public methods

extension MonthView {
	open func load(with viewModel: MonthViewModel, animated: Bool = true) {
		self.viewModel = viewModel
		self.viewModel.view = self

		headerHeightConstraint.constant = viewModel.headerHeight
		headerView.load(with: viewModel.headerSymbols)
		
		self.collectionView.delegate = self
		self.collectionView.dataSource = self

		self.collectionView.setCollectionViewLayout(viewModel.layout, animated: animated)
		self.collectionView.reloadData()
	}
}

// MARK: Private methods

private extension MonthView {
	func setUpStackView() {
		stackView.constraintToBounds(of: self)
		stackView.alignment = .fill
		stackView.axis = .vertical
		stackView.distribution = .fill

		headerView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 0)
		headerHeightConstraint.isActive = true

		stackView.addArrangedSubview(headerView)
		stackView.addArrangedSubview(collectionView)
	}
	
	func setUpCollectionView() {
		collectionView.register(DayView.self)
		collectionView.backgroundColor = .white
	}
}

// MARK: UICollectionDataSource methods

extension MonthView: UICollectionViewDataSource {
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfViewDays
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cell: DayView.self, at: indexPath)

		let dayViewModel = viewModel.dayViewModel(at: indexPath)
		cell.setUp(with: dayViewModel)
		
		return cell
	}
}

// MARK: UICollectionViewDelegate methods

extension MonthView: UICollectionViewDelegate {

}
