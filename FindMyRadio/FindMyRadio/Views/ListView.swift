import SwiftUI

struct ListView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var radioViewModel: RadioViewModel
    @ObservedObject var audioPlayerViewModel: AudioPlayerViewModel
    @Binding var showList: Bool

    var body: some View {
        Group {
            if showList {
                RadioListView(
                    locationManager: locationManager,
                    viewModel: radioViewModel,
                    audioPlayerViewModel: audioPlayerViewModel
                )
                .frame(maxHeight: .infinity)
            } else {
                VStack {
                    findRadioStationsButton
                    if radioViewModel.isFetchingData {
                        loadingIndicator
                    }
                }
            }
        }
    }

    private var findRadioStationsButton: some View {
        Button(action: fetchRadioData) {
            Text("Find Radio Stations")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .accessibilityIdentifier("FindRadioStationsButton")
    }

    private var loadingIndicator: some View {
        ProgressView("Fetching radio data...")
            .padding()
    }

    private func fetchRadioData() {
        if let location = locationManager.userLocation {
            radioViewModel.fetchRadioData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            showList = true
        } else {
            print("User location is not available")
        }
    }
}

#Preview {
    ListView(
        locationManager: LocationManager(),
        radioViewModel: RadioViewModel(),
        audioPlayerViewModel: AudioPlayerViewModel(),
        showList: .constant(false)
    )
}
