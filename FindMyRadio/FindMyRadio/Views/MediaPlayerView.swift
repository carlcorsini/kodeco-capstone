import SwiftUI

struct MediaPlayerView: View {
    @ObservedObject var audioPlayerViewModel: AudioPlayerViewModel

    var body: some View {
        HStack {
            Spacer()
            Text(audioPlayerViewModel.currentStation?.name ?? "Now Playing")
                .padding(.leading, 10)
            Spacer()
            Spacer()

            Button(
                action: {
                    if audioPlayerViewModel.isPlaying {
                        audioPlayerViewModel.stopStream()
                    } else {
                        if let currentStation = audioPlayerViewModel.currentStation,
                           let url = currentStation.url_resolved {
                            audioPlayerViewModel.playStream(url: url, station: currentStation)
                        }
                    }
                },
                label: {
                    Image(systemName: audioPlayerViewModel.isPlaying ? "pause.fill" : "play.fill")
                }
            )
            .padding(.horizontal, 10)

            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    MediaPlayerView(audioPlayerViewModel: AudioPlayerViewModel())
}
