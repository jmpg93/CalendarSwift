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

//		let viewModel = MonthViewModel(month: .current, mode: .monthly)
//		let view = MonthView(frame: self.view.bounds)

		view.load(with: viewModel)

		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			let viewModel = CalendarViewModel(year: year, mode: .monthly)
			view.set(mode: .weekly)
		})
		view.constraintToBounds(of: self.view)
	}
}

