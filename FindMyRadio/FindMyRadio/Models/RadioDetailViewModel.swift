//
//  RadioDetailViewModel.swift
//  FindMyRadio
//
//  Created by Carl Corsini on 7/23/24.
//

import Foundation
import SwiftUI

class RadioDetailViewModel: ObservableObject {
  @Published var radioStation: RadioStation
  @Published var faviconImage: UIImage?
  @Published var progress: Float = 0.0
  enum ImageDownloadError: Error {
    case invalidResponse
    case failedToStoreImage
  }
  init(radioStation: RadioStation) {
    self.radioStation = radioStation
  }
  func loadFavicon() async throws {
    guard let faviconURLString = radioStation.favicon, let url = URL(string: faviconURLString) else {
      return
    }
    let session = URLSession(configuration: .default)
    let (bytes, response) = try await session.bytes(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw ImageDownloadError.invalidResponse
    }
    let contentLength = Float(response.expectedContentLength)
    var data = Data()
    for try await byte in bytes {
      data.append(byte)
      let currentProgress = Float(data.count) / contentLength
      await MainActor.run {
        if Int(progress * 100) != Int(currentProgress * 100) {
          progress = currentProgress
        }
      }
    }
    if let imageData = UIImage(data: data) {
      await MainActor.run {
        faviconImage = imageData
      }
    } else {
      throw ImageDownloadError.failedToStoreImage
    }
  }
}
