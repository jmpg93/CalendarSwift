//
//  ViewController.swift
//  Calendar iOS
//
//  Created by Jose Maria Puerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit
import CalendarSwift

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.


		let view: CalendarView = CalendarView.instanceFromNib()
		view.translatesAutoresizingMaskIntoConstraints	= false
		view.frame = self.view.bounds
		view.backgroundColor = .red
		self.view.addSubview(view)
		view.load(with: CalendarViewModel(calendar: .current, startDate: Date()))

	}
}

