// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DetailedPlaylist : Codable {
    let id: Int
    let title, description: String
    let nbTracks, fans: Int
    let link, share, picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let checksum: String
    let tracklist: String
    let creationDate, md5Image, pictureType: String
    let creator: Creator
    let type: String
    let tracks: Tracks
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case nbTracks = "nb_tracks"
        case fans, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case checksum, tracklist
        case creationDate = "creation_date"
        case md5Image = "md5_image"
        case pictureType = "picture_type"
        case creator, type, tracks
    }
}

// MARK: - Creator
struct Creator : Codable {
    let id: Int?
    let name: String?
    let tracklist: String?
    let link: String?
}



