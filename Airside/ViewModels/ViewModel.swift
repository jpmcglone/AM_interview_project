import Foundation

class ViewModel<T> {
  let model: T
  
  init(_ model: T) {
    self.model = model
  }
}
