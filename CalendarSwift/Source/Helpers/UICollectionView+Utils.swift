//
//  UICollectionView+Utils.swift
//  CalendarSwift
//
//  Created by jmpuerta on 15/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
	func dequeue<T>(cell: T.Type, at indexPath: IndexPath) -> T where T: UICollectionViewCell {
		return dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! T
	}

	func register<T>(_ cell: T.Type) where T: UICollectionViewCell {
		register(cell, forCellWithReuseIdentifier: cell.identifier)
	}
}
