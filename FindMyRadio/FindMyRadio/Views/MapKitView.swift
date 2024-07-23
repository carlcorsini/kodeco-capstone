import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  @ObservedObject var locationManager: LocationManager

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView(frame: .zero)
    return mapView
  }

  func updateUIView(_ view: MKMapView, context: Context) {
    guard let coordinate = locationManager.userLocation?.coordinate else { return }
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    view.setRegion(region, animated: true)

    // Remove all existing annotations
    view.removeAnnotations(view.annotations)

    // Add a new annotation for the user's location
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    annotation.title = "You are here"
    view.addAnnotation(annotation)
  }
}
