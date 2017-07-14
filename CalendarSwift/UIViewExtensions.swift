import Foundation

extension UIView {
    func pinTo(view: UIView) {
        view.addSubview(self)
        view.layoutMargins = .zero
        translatesAutoresizingMaskIntoConstraints = false
    
        let margins = view.layoutMarginsGuide
        trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo:margins.bottomAnchor).isActive = true
        widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
    }
}
