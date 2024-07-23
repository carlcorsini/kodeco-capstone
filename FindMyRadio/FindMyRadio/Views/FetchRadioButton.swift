import SwiftUI

struct FetchRadioButton: View {
  @ObservedObject var locationManager: LocationManager
  @ObservedObject var radioViewModel: RadioViewModel
  var completion: (Bool) -> Void
  var body: some View {
    Button(
      action: {
        guard let location = locationManager.userLocation else {
          print("User location is not available")
          completion(false)
          return
        }
        radioViewModel.fetchRadioData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        completion(true)
      },
      label: {
        Text("Find Radio Stations")
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    )
    .accessibility(identifier: "FetchRadioButton")
    .shadow(radius: 5)
    .padding()
  }
}
