import Foundation

class GithubUserViewModel: ViewModel<GithubSearchItem> {
	let username: String
	let avatarUrl: URL?
	
	override init(_ model: GithubSearchItem) {
		self.username = "@\(model.login)"
		self.avatarUrl = model.avatarUrl
		
		super.init(model)
	}
}
