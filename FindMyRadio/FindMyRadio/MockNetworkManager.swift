import Foundation
import Combine

// Define a protocol to abstract the network operations
protocol NetworkManagerProtocol {
    func fetchRadioData(lat: Double, lon: Double) -> AnyPublisher<[RadioStation], Error>
}

// Implement the real network manager
class RealNetworkManager: NetworkManagerProtocol {
    func fetchRadioData(lat: Double, lon: Double) -> AnyPublisher<[RadioStation], Error> {
        guard let url = URL(string: "http://localhost:8000/radio?lat=\(lat)&lon=\(lon)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [RadioStation].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// Implement the mock network manager
class MockNetworkManager: NetworkManagerProtocol {
    var mockResponse: [RadioStation]?
    var mockError: Error?

    func fetchRadioData(lat: Double, lon: Double) -> AnyPublisher<[RadioStation], Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let response = mockResponse {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }
    }
}
