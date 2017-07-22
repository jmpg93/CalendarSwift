//
//  MontyViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class MonthViewLayout: UICollectionViewFlowLayout {
	public let viewModel: MonthViewModel
	private var lastBounds: CGRect = .zero

	public init(viewModel: MonthViewModel) {
		self.viewModel = viewModel
		super.init()
		setUp()
	}

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func setUp() {
		fatalError("Override this method")
	}

	public func dayViewModel(at indexPath: IndexPath) -> DayViewModelProtocol {
		fatalError("Override this method")
	}

	public var numberOfViewDays: Int {
		fatalError("Override this method")
	}

	public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		let shouldInvalidateLayout = lastBounds.width != newBounds.width
		lastBounds = newBounds
		return shouldInvalidateLayout
	}
}
