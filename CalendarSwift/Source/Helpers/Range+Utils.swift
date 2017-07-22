//
//  Range+Utils.swift
//  CalendarSwift
//
//  Created by Jose Maria Puerta on 22/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

extension Range where Bound == Int {
	var range: CountableRange<Int> {
		return  lowerBound..<upperBound
	}
}
