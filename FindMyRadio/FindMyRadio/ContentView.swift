import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    @StateObject private var audioPlayer = AudioPlayerViewModel()
    @State private var isFetchingData = false
    @State private var showList = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    MapView(locationManager: locationManager)
                        .frame(height: showList ? geometry.size.height / 3 : geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Button(action: {
                            if let location = locationManager.userLocation {
                                fetchRadioData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                                showList = true
                            }
                        }) {
                            Text("Fetch Radio Data")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 50)
                        }
                        .shadow(radius: 5)
                        
                        if isFetchingData {
                            ProgressView("Fetching radio data...")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.top, 10)
                        }
                    }
                }
                
                if showList {
                    VStack {
                        if !locationManager.radioData.isEmpty {
                            List(locationManager.radioData, id: \.stationuuid) { radioData in
                                HStack {
                                    if let faviconURL = radioData.favicon, let url = URL(string: faviconURL) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("Radio Station: \(radioData.name ?? "Unknown")")
                                            .font(.headline)
                                        Text("Country: \(radioData.country ?? "Unknown")")
                                        Text("State: \(radioData.state ?? "Unknown")")
                                        Text("Tags: \(radioData.tags ?? "Unknown")")
                                        Text("Language: \(radioData.language ?? "Unknown")")
                                        Text("URL: \(radioData.url_resolved ?? "Unknown")")
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                if let url = URL(string: radioData.url_resolved ?? "") {
                                                    UIApplication.shared.open(url)
                                                }
                                            }
                                        HStack {
                                            Button(action: {
                                                if let url = radioData.url_resolved {
                                                    audioPlayer.playStream(url: url)
                                                }
                                            }) {
                                                Text("Play")
                                            }
                                            .padding(.trailing, 10)
                                            
                                            Button(action: {
                                                audioPlayer.stopStream()
                                            }) {
                                                Text("Stop")
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    .frame(height: (2 * geometry.size.height) / 3)
                }
            }
        }
    }
    
    private func fetchRadioData(lat: Double, lon: Double) {
        isFetchingData = true
        guard let url = URL(string: "http://localhost:8000/radio?lat=\(lat)&lon=\(lon)") else {
            isFetchingData = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isFetchingData = false
            }
            guard let data = data else { return }
            
            // Print raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            do {
                let radioDataArray = try JSONDecoder().decode([RadioStation].self, from: data)
                DispatchQueue.main.async {
                    self.locationManager.radioData = radioDataArray
                }
            } catch {
                print("Failed to decode radio data: \(error.localizedDescription)")
            }
        }.resume()
    }
}


#Preview {
  ContentView()
}
