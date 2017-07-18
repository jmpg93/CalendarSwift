import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

protocol UICollectionViewDelegateFlowDirection: class {
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

class FlowCollectionView: UICollectionView, UICollectionViewDelegateFlowDirection {
	convenience init(frame: CGRect) {
		let layout = DirectionableFlowLayout()
		self.init(frame: frame, collectionViewLayout: layout)
		layout.delegate = self
	}

	var scrollDirection: UICollectionViewScrollDirection {
		return .horizontal
	}
}

FlowCollectionView(frame: .zero)
PlaygroundPage.current.needsIndefiniteExecution = true
