import ObjectMapper

class Base: Mappable {
  required init?(map: Map) { }
  func mapping(map: Map) { }
}
