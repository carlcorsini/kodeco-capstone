import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  @ObservedObject var locationManager: LocationManager
  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }
  func updateUIView(_ view: MKMapView, context: Context) {
    guard let coordinate = locationManager.userLocation?.coordinate else { return }
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(
      center: coordinate,
      span: span
    )
    view.setRegion(region, animated: true)
  }
}
