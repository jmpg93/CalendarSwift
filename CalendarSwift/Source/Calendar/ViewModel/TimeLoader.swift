//
//  TimeLoader.swift
//  CalendarSwift
//
//  Created by jmpuerta on 22/7/17.
//  Copyright © 2017 Jose Maria Puerta. All rights reserved.
//

import Foundation
import UIKit
import TimeSwift

public class TimeLoader {
	public enum Result {
		case inserted(years: [Year], indexPaths: [IndexPath], sections: IndexSet)
		case none
	}

	fileprivate let maximunDeltaToEnd: CGFloat = 1000.0
	fileprivate var isUpdating = false

	func scrollViewDidScroll(scrollView: UIScrollView, currentYears: [Year]) -> Result {

		let contentOffsetFromBottom = scrollView.contentOffset.y + scrollView.bounds.size.height
		let scrollToEndDelta = scrollView.contentSize.height - contentOffsetFromBottom

		guard isUpdating == false else {
			return .none
		}

		guard scrollToEndDelta <= maximunDeltaToEnd else {
			return .none
		}

		guard let lastContainedYear = currentYears.last else {
			return .none
		}

		guard !currentYears.contains(lastContainedYear.next) else {
			return .none
		}

		isUpdating = true

		let newYears = [lastContainedYear]
		let years = currentYears + newYears
		var indexPaths: [IndexPath] = []
		
		for section in years.indices where section >= currentYears.indices.upperBound {
			for item in years[section].months.indices {
				indexPaths += [IndexPath(item: item, section: section)]
			}
		}

		//let sections = IndexSet(integersIn: currentYears.indices.upperBound..<years.indices.upperBound)
		let sections = IndexSet(integer: 1)
		return .inserted(years: newYears, indexPaths: indexPaths, sections: sections)
	}
}
