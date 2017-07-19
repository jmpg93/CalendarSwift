//
//  MontyViewLayout.swift
//  CalendarSwift
//
//  Created by jmpuerta on 18/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import UIKit

public protocol MonthViewLayout {
	var minimumInteritemSpacing: CGFloat { get }
	var minimumLineSpacing: CGFloat { get }
	var scrollDirection: UICollectionViewScrollDirection { get }

	func numberOfDays(in month: MonthViewModel) -> Int
	func dayViewModel(at indexPath: IndexPath, in viewModel: MonthViewModel) -> DayViewModelProtocol
	
	func itemSize(at indexPath: IndexPath, in bounds: CGRect, using viewModel: MonthViewModel) -> CGSize
	func inset(in bounds: CGRect, using viewModel: MonthViewModel) -> UIEdgeInsets
}
