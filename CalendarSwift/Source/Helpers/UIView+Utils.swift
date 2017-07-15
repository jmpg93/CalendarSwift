//
//  UIView+Utils.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable {
	static var identifier: String { get }
	static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
	static var identifier: String {
		return String(describing: Self.self)
	}

	static var nib: UINib {
		let bundle = Bundle(for: Self.self)
		return UINib(nibName: identifier, bundle: bundle)
	}
}

extension UIView: NibLoadable { }

extension UIView {
	func pinToEdges(of view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(view)

		view.topAnchor.constraint(equalTo: topAnchor)
		view.bottomAnchor.constraint(equalTo: bottomAnchor)
		view.trailingAnchor.constraint(equalTo: trailingAnchor)
		view.leadingAnchor.constraint(equalTo: leadingAnchor)
	}
}
