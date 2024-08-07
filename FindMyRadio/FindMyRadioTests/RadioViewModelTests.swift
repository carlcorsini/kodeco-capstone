import XCTest
import Combine
@testable import FindMyRadio

class RadioViewModelTests: XCTestCase {
  var viewModel: RadioViewModel?
  var cancellables = Set<AnyCancellable>()
  override func setUp() {
    super.setUp()
    // Initialize the view model with a mock data fetcher
    viewModel = RadioViewModel(dataFetcher: mockDataFetcher)
  }
  override func tearDown() {
    viewModel = nil
    cancellables.removeAll()
    super.tearDown()
  }
  func testFetchRadioDataSuccess() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel is nil")
      return
    }
    // When fetching radio data
    viewModel.fetchRadioData(lat: 37.7749, lon: -122.4194)
    // Then the radio data should be updated
    let expectation = XCTestExpectation(description: "Fetch radio data")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(viewModel.isFetchingData)
      XCTAssertEqual(viewModel.radioData.count, 2)
      XCTAssertEqual(viewModel.radioData.first?.name, "Mock Station 1")
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 2.0)
  }
  func testToggleFavoriteAddsAndRemovesStation() {
    guard let viewModel = viewModel else {
      XCTFail("viewModel is nil")
      return
    }
    let station = RadioStation(
      stationuuid: "123",
      name: "Test Station",
      url: nil,
      url_resolved: nil,
      homepage: nil,
      country: nil,
      countrycode: nil,
      state: nil,
      language: nil,
      tags: nil,
      favicon: nil,
      iso_3166_2: nil,
      lastchangetime: nil,
      lastchangetime_iso8601: nil,
      lastchecktime: nil,
      lastchecktime_iso8601: nil,
      lastcheckoktime: nil,
      lastcheckoktime_iso8601: nil,
      lastlocalchecktime: nil,
      lastlocalchecktime_iso8601: nil,
      ssl_error: nil,
      geo_lat: nil,
      geo_long: nil,
      has_extended_info: nil
    )
    // Add to favorites
    viewModel.toggleFavorite(station: station)
    XCTAssertTrue(viewModel.isFavorite(station: station), "Station should be added to favorites")
    // Remove from favorites
    viewModel.toggleFavorite(station: station)
    XCTAssertFalse(viewModel.isFavorite(station: station), "Station should be removed from favorites")
  }
  private func mockDataFetcher(lat: Double, lon: Double) -> AnyPublisher<[RadioStation], Error> {
    let mockData = [
      RadioStation(
        stationuuid: "123",
        name: "Mock Station 1",
        url: nil,
        url_resolved: nil,
        homepage: nil,
        country: nil,
        countrycode: nil,
        state: nil,
        language: nil,
        tags: nil,
        favicon: nil,
        iso_3166_2: nil,
        lastchangetime: nil,
        lastchangetime_iso8601: nil,
        lastchecktime: nil,
        lastchecktime_iso8601: nil,
        lastcheckoktime: nil,
        lastcheckoktime_iso8601: nil,
        lastlocalchecktime: nil,
        lastlocalchecktime_iso8601: nil,
        ssl_error: nil,
        geo_lat: nil,
        geo_long: nil,
        has_extended_info: nil
      ),
      RadioStation(
        stationuuid: "456",
        name: "Mock Station 2",
        url: nil,
        url_resolved: nil,
        homepage: nil,
        country: nil,
        countrycode: nil,
        state: nil,
        language: nil,
        tags: nil,
        favicon: nil,
        iso_3166_2: nil,
        lastchangetime: nil,
        lastchangetime_iso8601: nil,
        lastchecktime: nil,
        lastchecktime_iso8601: nil,
        lastcheckoktime: nil,
        lastcheckoktime_iso8601: nil,
        lastlocalchecktime: nil,
        lastlocalchecktime_iso8601: nil,
        ssl_error: nil,
        geo_lat: nil,
        geo_long: nil,
        has_extended_info: nil
      )
    ]
    return Just(mockData)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  // Add more tests for error cases, etc.
}
