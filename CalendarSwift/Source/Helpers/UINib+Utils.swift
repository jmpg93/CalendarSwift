//
//  UINib+Utils.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

extension UINib {
	func instantiate<T: UIView>(owner:  Any? = nil) -> T {
		return instantiate(withOwner: owner, options: nil)[0] as! T
	}
}
