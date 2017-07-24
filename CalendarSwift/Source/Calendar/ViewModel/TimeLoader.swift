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

protocol TimeLoaderDelegate: class {
	var visibleMonths: [MonthViewModel] { get }
	func timeLoaderDidCreateTime(currentYears: [Year], createdYears: [Year], newIndexPaths: [IndexPath], newSections: IndexSet)
	func timeLoadedDidMove(from oldYear: Year, to newYear: Year)
}

class TimeLoader {
	weak var delegate: TimeLoaderDelegate?

	fileprivate let maximunDeltaToEnd: CGFloat = 2000.0
	fileprivate var currentYear: Year?
	fileprivate var isCreatingTime = false
	fileprivate var isVerifiyingTime = false
	fileprivate let creationQueue = DispatchQueue(label: "self.jmpg93.timeLoader.creation")
	fileprivate let verificationQueue = DispatchQueue(label: "self.jmpg93.timeLoader.verification")

	func scrollViewDidScroll(scrollView: UIScrollView, currentYears: [Year]) {
		verifyYearChange(scrollView: scrollView, currentYears: currentYears)
		createTimeIfNeeded(scrollView: scrollView, currentYears: currentYears)
	}
}

extension TimeLoader {
	func verifyYearChange(scrollView: UIScrollView, currentYears: [Year]) {
		guard isVerifiyingTime == false else {
			return
		}

		guard let months = delegate?.visibleMonths else {
			return
		}

		guard !months.isEmpty else {
			return
		}

		if currentYear == nil {
			currentYear = months.first!.year
		}

		isVerifiyingTime = true

		verificationQueue.async {
			let yearsByYear = months
				.map({ $0.year })
				.reduce([Year: Int](), { (dic, currentYear) -> [Year: Int] in
					var dic = dic
					let count = dic[currentYear] ?? 1
					dic[currentYear] = count + 1
					return dic
				})

			guard let mostRepeatedYear = yearsByYear.sorted(by: { $0.value > $1.value }).first?.key else {
				self.isVerifiyingTime = false
				return
			}

			DispatchQueue.main.async {
				if mostRepeatedYear != self.currentYear! {
					self.delegate?.timeLoadedDidMove(from: self.currentYear!, to: mostRepeatedYear)
					self.currentYear = mostRepeatedYear
				}
				self.isVerifiyingTime = false
			}
		}
	}

	func createTimeIfNeeded(scrollView: UIScrollView, currentYears: [Year]) {
		let contentOffsetFromBottom = scrollView.contentOffset.y + scrollView.bounds.size.height
		let scrollToEndDelta = scrollView.contentSize.height - contentOffsetFromBottom

		guard isCreatingTime == false else {
			return
		}

		guard scrollToEndDelta <= maximunDeltaToEnd else {
			return
		}

		guard let lastContainedYear = currentYears.last else {
			return
		}

		guard !currentYears.contains(lastContainedYear.next) else {
			return
		}

		isCreatingTime = true
		
		creationQueue.async {
			let createdYears = [lastContainedYear.next]
			var years = currentYears + createdYears
			var indexPaths: [IndexPath] = []

			for section in years.indices where section >= currentYears.indices.upperBound {
				for item in years[section].months.indices {
					indexPaths += [IndexPath(item: item, section: section)]
				}
			}

			let sections = IndexSet(integersIn: currentYears.indices.upperBound..<years.indices.upperBound)

			DispatchQueue.main.async {
				self.delegate?.timeLoaderDidCreateTime(currentYears: currentYears, createdYears: createdYears, newIndexPaths: indexPaths, newSections: sections)
				self.isCreatingTime = false
			}
		}
	}
}
