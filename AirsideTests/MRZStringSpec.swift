import Quick
import Nimble
@testable import Airside

class MRZStringSpec: QuickSpec {
  override func spec() {
    describe("MRZString") {
      context("single names") {
        let mrz = try! MRZString("P<USAROGGER<<MICHAEL<<<<<<<<<<<<<<<<<<<<<<<<")
        it("parsed correctly") {
          expect(mrz.names.count).to(equal(2))
          expect(mrz.prefix).to(equal("P<USA"))
          expect(mrz.country).to(equal("USA"))
          expect(mrz.names[0]).to(equal("ROGGER"))
          expect(mrz.names[1]).to(equal("MICHAEL"))
        }
      }
      context("multiple names") {
        let mrz = try! MRZString("P<USARICHARDS<STEVENS<JR<<GEORGE<MICHAEL<<<<")
        it("parsed correctly") {
          expect(mrz.names.count).to(equal(2))
          expect(mrz.prefix).to(equal("P<USA"))
          expect(mrz.names[0]).to(equal("RICHARDS STEVENS JR"))
          expect(mrz.names[1]).to(equal("GEORGE MICHAEL"))
        }
      }
      context("invalid mrz string") {
        it("failed") {
          expect { try MRZString("WRONG") }.to(throwError(MRZError.invalidRawString))
        }
      }
    }
    
    describe("MRZDetailsViewModel") {
      context("single names") {
        let mrz = try! MRZString("P<USAROGGER<<MICHAEL<<<<<<<<<<<<<<<<<<<<<<<<")
        let viewModel = MRZDetailsViewModel(mrz)
        it("should have parsed properly") {
          expect(viewModel.country).to(equal("United States"))
          expect(viewModel.fullName).to(equal("MICHAEL ROGGER"))
          expect(viewModel.model.raw).to(equal(mrz.raw))
        }
      }
    }
  }
}
