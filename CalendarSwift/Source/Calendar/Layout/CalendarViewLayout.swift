//
//  CalendarViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public class CalendarViewLayout: UICollectionViewFlowLayout {
	public let viewModel: CalendarViewModel

	public init(viewModel: CalendarViewModel) {
		self.viewModel = viewModel
		super.init()
		setUp()
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func setUp() {
		fatalError("Override this method")
	}

	public func monthViewModel(at indexPath: IndexPath) -> MonthViewModel {
		fatalError("Override this method")
	}

	public var numberOfMonths: Int {
		fatalError("Override this method")
	}
}
