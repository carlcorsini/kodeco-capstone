import SwiftUI
import Combine

class RadioViewModel: ObservableObject {
  @Published var radioData: [RadioStation] = []
  @Published var isFetchingData = false
  @Published var audioPlayer = AudioPlayerViewModel()
  @Published var favorites: [RadioStation] = []
  private let favoritesKey = "favoriteStations"
  private var cancellables = Set<AnyCancellable>()
  private var dataFetcher: ((Double, Double) -> AnyPublisher<[RadioStation], Error>)?
  init(dataFetcher: ((Double, Double) -> AnyPublisher<[RadioStation], Error>)? = nil) {
    self.dataFetcher = dataFetcher
    loadFavorites()
  }
  func fetchRadioData(lat: Double, lon: Double) {
    guard !isFetchingData else { return }
    isFetchingData = true
    let fetch: AnyPublisher<[RadioStation], Error>
    if let dataFetcher = dataFetcher {
      fetch = dataFetcher(lat, lon)
    } else {
      guard let url = URL(string: "http://localhost:8000/radio?lat=\(lat)&lon=\(lon)") else {
        isFetchingData = false
        return
      }
      fetch = URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: [RadioStation].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    fetch
      .replaceError(with: [])
      .receive(on: DispatchQueue.main)
      .sink { [weak self] newStations in
        self?.isFetchingData = false
        self?.radioData = newStations.unique() // Ensure no duplicates
      }
      .store(in: &cancellables)
  }
  func toggleFavorite(station: RadioStation) {
    if let index = favorites.firstIndex(where: { $0.stationuuid == station.stationuuid }) {
      favorites.remove(at: index)
    } else {
      favorites.append(station)
    }
    favorites = favorites.unique() // Ensure no duplicates
    saveFavorites()
  }
  func isFavorite(station: RadioStation) -> Bool {
    return favorites.contains { $0.stationuuid == station.stationuuid }
  }
  func saveFavorites() {
    if let encoded = try? JSONEncoder().encode(favorites) {
      UserDefaults.standard.set(encoded, forKey: favoritesKey)
    }
  }
  func loadFavorites() {
    if let data = UserDefaults.standard.data(forKey: favoritesKey),
      let savedFavorites = try? JSONDecoder().decode([RadioStation].self, from: data) {
      favorites = savedFavorites.unique()
    }
  }
}

extension Array where Element: Equatable {
  func unique() -> [Element] {
    var uniqueValues: [Element] = []
    for value in self where !uniqueValues.contains(value) {
      uniqueValues.append(value)
    }
    return uniqueValues
  }
}
