import SwiftUI

struct RadioListView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var viewModel: RadioViewModel
    @ObservedObject var audioPlayerViewModel: AudioPlayerViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.radioData, id: \.stationuuid) { radioData in
                    NavigationLink(destination: RadioDetailView(radioStation: radioData)) {
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
                                Text(radioData.name ?? "Unknown")
                                    .font(.headline)
                            }

                            Spacer()

                            HStack {
                                Button(
                                    action: {
                                        print("Play button tapped")
                                        if let url = radioData.url_resolved {
                                            audioPlayerViewModel.playStream(url: url, station: radioData)
                                        }
                                    },
                                    label: {
                                        Image(systemName: "play.fill")
                                            .foregroundColor(.blue)
                                    }
                                )
                                .buttonStyle(PlainButtonStyle())

                                Button(
                                    action: {
                                        print("Stop button tapped")
                                        audioPlayerViewModel.stopStream()
                                    },
                                    label: {
                                        Image(systemName: "stop.fill")
                                            .foregroundColor(.red)
                                    }
                                )
                                .buttonStyle(PlainButtonStyle())

                                Button(
                                    action: {
                                        viewModel.toggleFavorite(station: radioData)
                                    },
                                    label: {
                                        Image(
                                            systemName:
                                              viewModel.isFavorite(station: radioData) ? "heart.fill" : "heart"
                                        )
                                        .foregroundColor(
                                            viewModel.isFavorite(station: radioData) ? .yellow : .gray
                                        )
                                    }
                                )
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.leading, 10)
                        }
                        .contentShape(Rectangle())
                    }
                }
            }
            .refreshable {
                if let location = locationManager.userLocation {
                    viewModel.fetchRadioData(
                        lat: location.coordinate.latitude,
                        lon: location.coordinate.longitude
                    )
                } else {
                    print("User location is not available")
                }
            }
            .overlay {
                if viewModel.isFetchingData {
                    ZStack {
                        ProgressView("Fetching radio data...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(UIColor.darkGray))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}
