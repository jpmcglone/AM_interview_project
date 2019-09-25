import UIKit

class ApplicationController {
  static var shared = ApplicationController()
  
  func openGithubProfile(fromGithubSearchItem item: GithubSearchItem) {
    guard let url = item.htmlUrl else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
