// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let tracks: Tracks?
    let albums: Albums?
    let artists: Artists?
    let playlists: Playlists?
    let podcasts: Podcasts?
}

// MARK: - Albums
struct Albums: Codable {
    let data: [AlbumsDatum]?
    let total: Int?
}

// MARK: - AlbumsDatum
struct AlbumsDatum: Codable {
    let id: Int?
    let title: String?
    let link, cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let recordType: RecordTypeEnum?
    let tracklist: String?
    let explicitLyrics: Bool?
    let position: Int?
    let artist: ArtistElement?
    let type: RecordTypeEnum?

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case recordType = "record_type"
        case tracklist
        case explicitLyrics = "explicit_lyrics"
        case position, artist, type
    }
}

// MARK: - ArtistElement
struct ArtistElement: Codable {
    let id: Int?
    let name: String?
    let link, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let radio: Bool?
    let tracklist: String?
    let type: ArtistType?
    let position: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type, position
    }
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

enum RecordTypeEnum: String, Codable {
    case album = "album"
    case ep = "ep"
}

// MARK: - Artists
struct Artists: Codable {
    let data: [ArtistElement]?
    let total: Int?
}

// MARK: - Playlists
struct Playlists: Codable {
    let data: [PlaylistsDatum]?
    let total: Int?
}

// MARK: - PlaylistsDatum
struct PlaylistsDatum: Codable {
    let id: Int?
    let title: String?
    let datumPublic: Bool?
    let nbTracks: Int?
    let link, picture: String?
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    let checksum: String?
    let tracklist: String?
    let creationDate, md5Image: String?
    let pictureType: PictureTypeEnum?
    let user: User?
    let type: PictureTypeEnum?

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumPublic = "public"
        case nbTracks = "nb_tracks"
        case link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case checksum, tracklist
        case creationDate = "creation_date"
        case md5Image = "md5_image"
        case pictureType = "picture_type"
        case user, type
    }
}

enum PictureTypeEnum: String, Codable {
    case playlist = "playlist"
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let tracklist: String?
    let type: UserType?
}

enum UserType: String, Codable {
    case user = "user"
}

// MARK: - Podcasts
struct Podcasts: Codable {
    let data: [PodcastsDatum]?
    let total: Int?
}

// MARK: - PodcastsDatum
struct PodcastsDatum: Codable {
    let id: Int?
    let title, description: String?
    let available: Bool?
    let fans: Int?
    let link, share: String?
    let picture, pictureSmall, pictureMedium, pictureBig: String?
    let pictureXl: String?
    let type: PurpleType?

    enum CodingKeys: String, CodingKey {
        case id, title, description, available, fans, link, share, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case type
    }
}

enum PurpleType: String, Codable {
    case podcast = "podcast"
}

// MARK: - Tracks
struct Tracks: Codable {
    let data: [TracksDatum]?
    let total: Int?
}

// MARK: - TracksDatum
struct TracksDatum: Codable {
    let id: Int?
    let title, titleShort, titleVersion: String?
    let link: String?
    let duration, rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let md5Image: String?
    let position: Int?
    let artist: ArtistElement?
    let album: Album?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case position, artist, album, type
    }
}

// MARK: - Album
struct Album: Codable {
    let id: Int?
    let title: String?
    let cover: String?
    let coverSmall, coverMedium, coverBig, coverXl: String?
    let md5Image: String?
    let tracklist: String?
    let type: RecordTypeEnum?

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case tracklist, type
    }
}
