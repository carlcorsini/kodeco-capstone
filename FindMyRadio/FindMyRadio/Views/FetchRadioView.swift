import SwiftUI

struct FetchRadioView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var radioViewModel: RadioViewModel
    @Binding var navigateToList: Bool

    var body: some View {
        VStack {
            FetchRadioButton(locationManager: locationManager, radioViewModel: radioViewModel, completion: { success in
                navigateToList = success
            })

            if radioViewModel.isFetchingData {
                ProgressView("Fetching radio data...")
                    .padding()
            }
        }
    }
}
