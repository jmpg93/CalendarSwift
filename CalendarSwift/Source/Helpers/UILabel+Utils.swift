//
//  UILabel+Utils.swift
//  CalendarSwift
//
//  Created by jmpuerta on 19/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	public convenience init(text: String) {
		self.init()
		self.textAlignment = .center
		self.text = text
	}
}
