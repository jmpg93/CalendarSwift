//
//  DayViewModel.swift
//  CalendarSwift
//
//  Created by jmpuerta on 14/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import TimeSwift

public struct DayViewModel: DayViewModelProtocol {
	fileprivate let day: Day
	
	public init(day: Day) {
		self.day = day
	}

	public var dayValue: String {
		return String(day.day)
	}
}
