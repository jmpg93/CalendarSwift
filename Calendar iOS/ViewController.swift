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

		let viewModel = CalendarViewModel(startDate: Date())
		let view = CalendarView(frame: self.view.bounds)
		view.load(with: viewModel)

		view.constraintToBounds(of: self.view)
	}
}

