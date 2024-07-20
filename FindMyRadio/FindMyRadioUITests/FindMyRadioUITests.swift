import XCTest

class FindMyRadioUITests: XCTestCase {
  var app: XCUIApplication?
  override func setUpWithError() throws {
    continueAfterFailure = false
    app = XCUIApplication()
    app?.launch()
  }
  override func tearDownWithError() throws {
    app = nil
  }
  func testExample() throws {
    // Ensure the app is not nil before using it
    // UI test example
  }
}
