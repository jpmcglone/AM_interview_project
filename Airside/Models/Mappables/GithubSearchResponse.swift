import ObjectMapper

class GithubSearchResponse: Base {
  var totalCount = 0
  var incompleteResults = false
  var items = [GithubSearchItem]()
  
  override func mapping(map: Map) {
    super.mapping(map: map)
    totalCount <- map["total_count"]
    incompleteResults <- map["incomplete_results"]
    items <- map["items"]
  }
}
