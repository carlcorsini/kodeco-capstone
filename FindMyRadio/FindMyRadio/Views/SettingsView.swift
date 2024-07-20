import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: RadioViewModel
    @ObservedObject var audioPlayerViewModel: AudioPlayerViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favorites, id: \.stationuuid) { radioData in
                    NavigationLink(destination: RadioDetailView(radioStation: radioData)) {
                        RadioRow(radioData: radioData, audioPlayerViewModel: audioPlayerViewModel, viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Favorites")
            .overlay {
                if viewModel.isFetchingData {
                    LoadingView()
                }
            }
        }
    }
}

struct RadioRow: View {
    let radioData: RadioStation
    @ObservedObject var audioPlayerViewModel: AudioPlayerViewModel
    @ObservedObject var viewModel: RadioViewModel

    var body: some View {
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
                Button(action: {
                    print("Play button tapped")
                    if let url = radioData.url_resolved {
                        audioPlayerViewModel.playStream(url: url, station: radioData)
                    }
                }, label: {
                    Image(systemName: "play.fill")
                        .foregroundColor(.blue)
                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    print("Stop button tapped")
                    audioPlayerViewModel.stopStream()
                }, label: {
                    Image(systemName: "stop.fill")
                        .foregroundColor(.red)
                })
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    viewModel.toggleFavorite(station: radioData)
                }, label: {
                    Image(systemName: viewModel.isFavorite(station: radioData) ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite(station: radioData) ? .yellow : .gray)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.leading, 10)
        }
        .contentShape(Rectangle())
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView("Fetching favorite stations...")
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.white)
                .padding()
                .background(Color(UIColor.darkGray))
                .cornerRadius(10)
        }
    }
}
