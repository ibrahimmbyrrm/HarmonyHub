//
//  Album Model.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let baseAlbum = try? JSONDecoder().decode(BaseAlbum.self, from: jsonData)

import Foundation

// MARK: - BaseAlbum
struct BaseAlbum: Codable {
    let id: Int
    let title: String
    let link, cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let genreID: Int
    let fans: Int
    let releaseDate: String
    let tracklist: String
    let explicitLyrics: Bool
    let artist: ArtistOfAlbum?
    let tracks: Tracks?

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case genreID = "genre_id"
        case fans
        case releaseDate = "release_date"
        case tracklist
        case explicitLyrics = "explicit_lyrics"
        case artist, tracks
    }
}

// MARK: - Artist
struct ArtistOfAlbum: Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let tracklist: String
    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case tracklist
    }
}

// MARK: - Contributor
struct Contributor: Codable {
    let id: Int
    let link, share, picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let radio: Bool
    let tracklist: String
    let role: String

    enum CodingKeys: String, CodingKey {
        case id, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, role
    }
}


