import Foundation

// swiftlint:disable identifier_name

struct RadioStation: Codable, Identifiable, Equatable {
    var id: String { stationuuid }
    let stationuuid: String
    let name: String?
    let url: String?
    let url_resolved: String?
    let country: String?
    let countrycode: String?
    let state: String?
    let language: String?
    let tags: String?
    let favicon: String?
    let iso_3166_2: String?
    let lastchangetime: String?
    let lastchangetime_iso8601: String?
    let lastchecktime: String?
    let lastchecktime_iso8601: String?
    let lastcheckoktime: String?
    let lastcheckoktime_iso8601: String?
    let lastlocalchecktime: String?
    let lastlocalchecktime_iso8601: String?
    let clicktimestamp: String?
    let clicktimestamp_iso8601: String?
    let ssl_error: Int?
    let geo_lat: Double?
    let geo_long: Double?
    let has_extended_info: Bool?

    // Conform to Equatable by implementing the equality operator
    static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return lhs.stationuuid == rhs.stationuuid
    }
}

// swiftlint:enable identifier_name
