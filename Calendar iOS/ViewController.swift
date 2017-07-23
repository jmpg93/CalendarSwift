//
//  ViewController.swift
//  Calendar iOS
//
//  Created by Jose Maria Puerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit
import CalendarSwift
import TimeSwift

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		var calendar = Calendar.current
		calendar.locale = .current

		let year = Year(date: Date(), in: calendar)

		let viewModel = CalendarViewModel(year: year, mode: .monthly)
		let view = CalendarView(frame: self.view.bounds)

		view.load(with: viewModel)

		view.constraintToBounds(of: self.view)
	}
}

