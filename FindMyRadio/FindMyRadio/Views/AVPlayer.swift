import SwiftUI
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    private var player: AVPlayer?
    @Published var isPlaying: Bool = false
    @Published var currentStation: RadioStation?
    @Published var radioStations: [RadioStation] = []

    func playStream(url: String, station: RadioStation) {
        guard let streamURL = URL(string: url) else { return }
        player = AVPlayer(url: streamURL)
        player?.play()
        isPlaying = true
        currentStation = station
    }

    func stopStream() {
        player?.pause()
        player = nil
        isPlaying = false
        currentStation = nil
    }
}
