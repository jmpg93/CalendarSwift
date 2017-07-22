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
	fileprivate let maximunDeltaToEnd: CGFloat = 1000.0

	func scrollViewDidScroll(scrollView: UIScrollView, currentYears years: [Year]) -> [Year] {
		let contentOffsetFromBottom = (scrollView.contentOffset.y + scrollView.bounds.size.height)
		let scrollToEndDelta = scrollView.contentSize.height - contentOffsetFromBottom

		guard scrollToEndDelta >= maximunDeltaToEnd else {
			return []
		}

		guard let lastContainedYear = years.last else {
			return [Year(date: Date())]
		}

		guard !years.contains(lastContainedYear.next) else {
			return []
		}

		return [lastContainedYear]
	}
}
