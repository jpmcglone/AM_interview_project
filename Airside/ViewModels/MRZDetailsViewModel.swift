import Foundation

class MRZDetailsViewModel: ViewModel<MRZString> {
	let country: String
	let fullName: String
	
	override init(_ model: MRZString) {
		self.country = MRZDetailsViewModel.fullCountryName(model.country)
		self.fullName = model.fullName
		
		super.init(model)
	}
	
	private static func fullCountryName(_ country: String) -> String {
		switch country.uppercased() {
		case "USA": return "United States"
		case "MEX": return "Mexico"
		case "FRA": return "France"
		case "CAN": return "Canada"
		default: return country
		}
	}
}
