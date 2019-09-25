import UIKit

class BetterTextField: UITextField {
  var edgeInsets: UIEdgeInsets = .zero {
    didSet {
      setNeedsLayout()
    }
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: edgeInsets)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: edgeInsets)
  }
}
