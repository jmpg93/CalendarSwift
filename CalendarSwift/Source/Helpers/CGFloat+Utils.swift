//
//  CGFloat+Utils.swift
//  CalendarSwift
//
//  Created by jmpuerta on 22/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

extension CGFloat {
	var floored: CGFloat {
		return floor(self)
	}
}

extension CGSize {
	var floored: CGSize {
		return CGSize(width: width.floored, height: height.floored)
	}
}
