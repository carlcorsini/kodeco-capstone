import SwiftUI

struct RadioDetailView: View {
  @StateObject var viewModel: RadioDetailViewModel
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 10) {
        if let image = viewModel.faviconImage {
          Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
          Image(systemName: "photo")
            .resizable()
            .frame(width: 100, height: 100)
            .onAppear {
              Task {
                try? await viewModel.loadFavicon()
              }
            }
        }
        // Display radio station details
        Group {
          Text("Name: \(viewModel.radioStation.name ?? "Unknown")")
            .font(.title)
          Text("Country: \(viewModel.radioStation.country ?? "Unknown")")
            .font(.subheadline)
          Text("State: \(viewModel.radioStation.state ?? "Unknown")")
            .font(.subheadline)
          Text("Tags: \(viewModel.radioStation.tags ?? "Unknown")")
            .font(.subheadline)
          Text("Language: \(viewModel.radioStation.language ?? "Unknown")")
            .font(.subheadline)
          Text("Homepage: \(viewModel.radioStation.homepage ?? "Unknown")")
            .font(.subheadline)
            .foregroundColor(.blue)
            .onTapGesture {
              if let homepage = URL(string: viewModel.radioStation.homepage ?? "") {
                UIApplication.shared.open(homepage)
              }
            }
          Text("Stream URL: \(viewModel.radioStation.url_resolved ?? "Unknown")")
            .font(.subheadline)
            .foregroundColor(.blue)
            .onTapGesture {
              if let url = URL(string: viewModel.radioStation.url_resolved ?? "") {
                UIApplication.shared.open(url)
              }
            }
        }
        // Display additional radio station details if available
        Group {
          if let countryCode = viewModel.radioStation.countrycode {
            Text("Country Code: \(countryCode)")
              .font(.subheadline)
          }
          if let isoCode = viewModel.radioStation.iso_3166_2 {
            Text("ISO 3166-2: \(isoCode)")
              .font(.subheadline)
          }
          if let lastChangeTime = viewModel.radioStation.lastchangetime {
            Text("Last Change Time: \(lastChangeTime)")
              .font(.subheadline)
          }
          if let lastCheckTime = viewModel.radioStation.lastchecktime {
            Text("Last Check Time: \(lastCheckTime)")
              .font(.subheadline)
          }
          if let lastCheckOkTime = viewModel.radioStation.lastcheckoktime {
            Text("Last Check OK Time: \(lastCheckOkTime)")
              .font(.subheadline)
          }
          if let lastLocalCheckTime = viewModel.radioStation.lastlocalchecktime {
            Text("Last Local Check Time: \(lastLocalCheckTime)")
              .font(.subheadline)
          }
          if let sslError = viewModel.radioStation.ssl_error {
            Text("SSL Error: \(sslError)")
              .font(.subheadline)
          }
          if let geoLat = viewModel.radioStation.geo_lat, let geoLong = viewModel.radioStation.geo_long {
            Text("Geo Location: (\(geoLat), \(geoLong))")
              .font(.subheadline)
          }
          if let hasExtendedInfo = viewModel.radioStation.has_extended_info {
            Text("Has Extended Info: \(hasExtendedInfo ? "Yes" : "No")")
              .font(.subheadline)
          }
        }
        Spacer()
      }
      .padding()
    }
    .navigationTitle("Radio Details")
  }
}
