import ObjectMapper

class GithubSearchItem: Base {
  var login = ""
  var id = 000
  var nodeId = ""
  var avatarUrl: URL?
  var gravatarId = ""
  var url = ""
  var type = ""
  var siteAdmin = false
  var score = 0.0
  var htmlUrl: URL?
  
  /*
   TODO:
   var followersUrl = ""
   var followingUrl = ""
   var gistsUrl = ""
   var starredUrl = ""
   var subscriptionUrl = ""
   var organizationsUrl = ""
   var reposUrl = ""
   var eventsUrl = ""
   var receivedEventsUrl = ""
   */
  
  override func mapping(map: Map) {
    super.mapping(map: map)
    
    login <- map["login"]
    id <- map["id"]
    nodeId <- map["node_id"]
    avatarUrl <- (map["avatar_url"], URLTransform())
    gravatarId <- map["gravatar_id"]
    url <- map["url"]
    htmlUrl <- (map["html_url"], URLTransform())
    type <- map["type"]
    siteAdmin <- map["site_admin"]
    score <- map["score"]
  }
}
