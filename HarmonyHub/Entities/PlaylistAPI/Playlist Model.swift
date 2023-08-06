// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DetailedPlaylist : Codable {
    let id: Int?
    let title, description: String?
    let duration: Int?
    let isLovedTrack, collaborative: Bool?
    let nbTracks, fans: Int?
    let link, share, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let checksum: String?
    let tracklist: String?
    let creationDate, md5Image, pictureType: String?
    let creator: Creator?
    let type: String?
    let tracks: Tracks?
}

// MARK: - Creator
struct Creator : Codable {
    let id: Int?
    let name: String?
    let tracklist: String?
    let link: String?
}



