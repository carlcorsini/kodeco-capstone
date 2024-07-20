import XCTest

final class FindMyRadioUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let findMyRadioNavigationBar = app.navigationBars["FindMyRadio"]
        let findMyRadioStaticText = findMyRadioNavigationBar.staticTexts["FindMyRadio"]
        XCTAssert(findMyRadioStaticText.exists)
    }
}
