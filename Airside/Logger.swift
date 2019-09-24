import SwiftyBeaver

let Logger = LoggerManager.shared

enum LoggerType {
  case verbose, debug, info, warning, error
}

class LoggerManager {
  static let shared = LoggerManager()
  private let log = SwiftyBeaver.self
  init() {
    let console = ConsoleDestination()
    let file = FileDestination()
    
    log.addDestination(console)
    log.addDestination(file)
  }
  
  func log(_ message: Any, context: Any? = nil, _ type: LoggerType = .verbose) {
    switch type {
    case .verbose: log.verbose(message)
    case .debug: log.debug(message)
    case .info: log.info(message)
    case .warning: log.warning(message)
    case .error: log.error(message)
    }
  }
}
