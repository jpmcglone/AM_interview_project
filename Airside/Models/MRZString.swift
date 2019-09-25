import Foundation

fileprivate let prefixLength = 5

struct MRZString {
  let raw: String
  let prefix: String
  let country: String
  let names: [String]
  
  // Convenience
  let fullName: String
  
  init(_ raw: String) throws {
    self.raw = raw
    self.prefix = String(raw.prefix(prefixLength))
    
    let prefixComponents = prefix.components(separatedBy: "<")
    
    guard prefixComponents.count == 2 else {
      throw MRZError.invalidRawString
    }
    
    self.country = prefixComponents[1]
    
    // Parse the raw string
    let last = raw.dropFirst(prefixLength)
    let rawNames = last.components(separatedBy: "<<")
    var names = [String]()
    
    for name in rawNames {
      let n = name.replacingOccurrences(of: "<", with: " ")
      names.append(n)
    }
    self.names = names.filter { $0.count > 0 && $0 != ">" }
    
    self.fullName = self.names.reversed().joined(separator: " ")
  }
}
