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
	public func constraintToBounds(of view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(self)

		topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
	}
}
