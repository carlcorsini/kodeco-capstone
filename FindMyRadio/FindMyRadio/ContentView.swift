import SwiftUI
import MapKit

struct ContentView: View {
  @ObservedObject var locationManager = LocationManager()
  @StateObject private var radioViewModel = RadioViewModel()
  @StateObject private var audioPlayerViewModel = AudioPlayerViewModel()
  @State private var showList = false
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        GeometryReader { _ in
          MapView(locationManager: locationManager)
            .accessibilityIdentifier("MapView")
            .edgesIgnoringSafeArea(.all)
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        MediaPlayerView(audioPlayerViewModel: audioPlayerViewModel)
          .accessibilityIdentifier("MediaPlayerView")
          .frame(height: 80)
          .background(Color.gray.opacity(0.2))
        TabView {
          NavigationStack {
            ListView(
              locationManager: locationManager,
              radioViewModel: radioViewModel,
              audioPlayerViewModel: audioPlayerViewModel,
              showList: $showList
            )
          }
          .tabItem {
            Label("Home", systemImage: "house")
          }
          NavigationStack {
            SettingsView(
              viewModel: radioViewModel,
              audioPlayerViewModel: audioPlayerViewModel
            )
          }
          .tabItem {
            Label("Favorites", systemImage: "heart")
          }
        }
        .frame(maxHeight: .infinity)
      }
      .navigationBarHidden(true)
    }
    .onAppear {
      audioPlayerViewModel.radioStations = radioViewModel.radioData
    }
  }
}

#Preview {
  ContentView()
}
