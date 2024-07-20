import SwiftUI

struct RadioDetailView: View {
    let radioStation: RadioStation

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let faviconURL = radioStation.favicon, let url = URL(string: faviconURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 100, height: 100)
            }

            Text("Name: \(radioStation.name ?? "Unknown")")
                .font(.title)
            Text("Country: \(radioStation.country ?? "Unknown")")
                .font(.subheadline)
            Text("State: \(radioStation.state ?? "Unknown")")
                .font(.subheadline)
            Text("Tags: \(radioStation.tags ?? "Unknown")")
                .font(.subheadline)
            Text("Language: \(radioStation.language ?? "Unknown")")
                .font(.subheadline)
            Text("Stream URL: \(radioStation.url_resolved ?? "Unknown")")
                .font(.subheadline)
                .foregroundColor(.blue)
                .onTapGesture {
                    if let url = URL(string: radioStation.url_resolved ?? "") {
                        UIApplication.shared.open(url)
                    }
                }
            Spacer()
        }
        .padding()
        .navigationTitle("Radio Details")
    }
}
