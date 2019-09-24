import Foundation
import Alamofire
import AlamofireObjectMapper

class GithubSearchItemsViewModel {
	private(set) var items = [GithubSearchItem]()
	
	private(set) var lastResponse: GithubSearchResponse?
	private(set) var error: Error?
	private(set) var query: String = ""
	
	// Pagination
	private(set) var page = 0
	private(set) var hasNext = true
	
	private(set) var loading = false
	private(set) var dataRequest: DataRequest?
	
	var totalCount: Int {
		return lastResponse?.totalCount ?? 0
	}
	
	var seeAllButtonText: String {
		return "See all \(totalCount) results"
	}
	
	var topSearchItem: GithubSearchItem? {
		return items.first
	}
	
	// Do a fresh search of a given query
	func searchUsers(_ query: String, completion: ((GithubSearchItemsViewModel)->())? = nil) {
		// Clear items
		clear()
		self.query = query
		searchUsers(query, page: 1, completion: completion)
	}
	
	// Fetch the next page of current query
	func fetchNextPage(completion: ((GithubSearchItemsViewModel)->())? = nil) {
		guard hasNext && !loading else { return }
		searchUsers(query, page: page + 1, completion: completion)
	}
	
	func clear() {
		error = nil
		dataRequest?.cancel()
		dataRequest = nil
		page = 0
		items.removeAll()
		query = ""
		hasNext = true
	}
	
	func setError(_ error: Error?) {
		self.error = error
	}
	
	private func searchUsers(_ query: String, page: Int, completion: ((GithubSearchItemsViewModel)->())?) {
		Logger.log("Searching users with query `\(query)`, page `\(page)`...")
		var parameters = [String: Any]()
		parameters["q"] = query
		parameters["page"] = page
		
		loading = true
		Alamofire.request("https://api.github.com/search/users", parameters: parameters).responseObject { (response: DataResponse<GithubSearchResponse>) in
			self.loading = false
			switch response.result {
			case .success(let response):
				// TODO: use the 'Links' in the response header
				
				// For now, if response.items is blank, consider it the last page
				if response.items.count == 0 {
					self.hasNext = false
				}
				self.items.append(contentsOf: response.items)
				self.lastResponse = response
				self.error = nil
				self.page = page
				Logger.log("This page: \(response.items.count)")
				Logger.log("Total count: \(response.totalCount)")
				Logger.log("Done.")
			case .failure(let error):
				self.lastResponse = nil
				self.error = error
				Logger.log("Failed.")
			}
			completion?(self)
		}
	}
}
