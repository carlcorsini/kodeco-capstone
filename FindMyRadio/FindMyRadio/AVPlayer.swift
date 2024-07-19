import Foundation
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    private var player: AVPlayer?
    
    @Published var isPlaying = false
    
    func playStream(url: String) {
        guard let streamURL = URL(string: url) else { return }
        
        player = AVPlayer(url: streamURL)
        player?.play()
        isPlaying = true
    }
    
    func stopStream() {
        player?.pause()
        isPlaying = false
    }
}
