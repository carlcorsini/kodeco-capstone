import Foundation

struct RadioStation: Codable {
    let changeuuid: String?
    let stationuuid: String?
    let serveruuid: String?
    let name: String?
    let url: String?
    let url_resolved: String?
    let homepage: String?
    let favicon: String?
    let tags: String?
    let country: String?
    let countrycode: String?
    let state: String?
    let language: String?
    let languagecodes: String?
    let votes: Int?
    let lastchangetime: String?
    let lastchangetime_iso8601: String?
    let codec: String?
    let bitrate: Int?
    let hls: Int?
    let lastcheckok: Int?
    let lastchecktime: String?
    let lastchecktime_iso8601: String?
    let lastcheckoktime: String?
    let lastcheckoktime_iso8601: String?
    let lastlocalchecktime: String?
    let lastlocalchecktime_iso8601: String?
    let clicktimestamp: String?
    let clicktimestamp_iso8601: String?
    let clickcount: Int?
    let clicktrend: Int?
    let ssl_error: Int?
    let geo_lat: Double?
    let geo_long: Double?
    let has_extended_info: Bool?
}
