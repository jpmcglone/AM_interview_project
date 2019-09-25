import Quick
import Nimble
@testable import Airside

// TODO: break down into more files
class AirsideSpec: QuickSpec {
  override func spec() {		
    describe("GithubSearchItem") {
      let item = GithubSearchItem(JSONString:
        """
			{"login":"Rogger","id":371835,"node_id":"MDQ6VXNlcjM3MTgzNQ==","avatar_url":"https://avatars2.githubusercontent.com/u/371835?v=4","gravatar_id":"","url":"https://api.github.com/users/Rogger","html_url":"https://github.com/Rogger","followers_url":"https://api.github.com/users/Rogger/followers","following_url":"https://api.github.com/users/Rogger/following{/other_user}","gists_url":"https://api.github.com/users/Rogger/gists{/gist_id}","starred_url":"https://api.github.com/users/Rogger/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/Rogger/subscriptions","organizations_url":"https://api.github.com/users/Rogger/orgs","repos_url":"https://api.github.com/users/Rogger/repos","events_url":"https://api.github.com/users/Rogger/events{/privacy}","received_events_url":"https://api.github.com/users/Rogger/received_events","type":"User","site_admin":false,"score":545.00916}
			"""
        )!
      it("should have parsed properly") {
        expect(item.login).to(equal("Rogger"))
        expect(item.id).to(equal(371835))
        expect(item.avatarUrl).to(equal(URL(string: "https://avatars2.githubusercontent.com/u/371835?v=4")))
      }
      
      context("GithubUserViewModel") {
        let viewModel = GithubUserViewModel(item)
        it("should work") {
          expect(viewModel.username).to(equal("@Rogger"))
          expect(viewModel.avatarUrl).to(equal(URL(string: "https://avatars2.githubusercontent.com/u/371835?v=4")))
        }
      }
    }
    
    describe("GithubSearchItemsViewModel") {
      let searchItemsViewModel = GithubSearchItemsViewModel()
      
      it("should clear properly") {
        searchItemsViewModel.setError(MRZError.invalidRawString)
        expect(searchItemsViewModel.error as? MRZError).to(equal(MRZError.invalidRawString))
        searchItemsViewModel.clear()
        expect(searchItemsViewModel.error as? MRZError).to(beNil())
        expect(searchItemsViewModel.items.count).to(equal(0))
      }
    }
    
    describe("GithubSearchResponse") {
      let response = GithubSearchResponse(JSONString:
        """
{"total_count":30,"incomplete_results":false,"items":[]}
"""
        )!
      expect(response.totalCount).to(equal(30))
      expect(response.incompleteResults).to(equal(false))
      expect(response.items.count).to(equal(0))
    }
  }
}
