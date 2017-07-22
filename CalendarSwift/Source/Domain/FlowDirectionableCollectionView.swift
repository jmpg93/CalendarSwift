//
//  DirectionableCollectionView.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation

protocol UICollectionViewDelegateFlowDirection: UICollectionViewDelegateFlowLayout {
	var scrollDirection: UICollectionViewScrollDirection { get }
}

class DirectionableFlowLayout: UICollectionViewFlowLayout {
	weak var delegate: UICollectionViewDelegateFlowDirection?

	override func prepare() {
		super.prepare()
		guard let delegate = delegate else {
			return
		}

		self.scrollDirection = delegate.scrollDirection
	}
}

class FlowDirectionableCollectionView: UICollectionView, UICollectionViewDelegateFlowDirection {
	weak var flowDelegate: UICollectionViewDelegateFlowDirection? {
		didSet { self.delegate = flowDelegate }
	}

	convenience init(frame: CGRect) {
		let layout = DirectionableFlowLayout()
		self.init(frame: frame, collectionViewLayout: layout)
		layout.delegate = self
	}

	var scrollDirection: UICollectionViewScrollDirection {
		return flowDelegate?.scrollDirection ?? .vertical
	}
}