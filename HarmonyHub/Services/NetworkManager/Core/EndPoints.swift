//
//  EndPoints.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation

protocol EndPointType {
    var path : String {get}
    var baseUrl : String {get}
    var url : URL? {get}
    var method : httpMethods {get}
}

enum EndPointItems<T : Decodable> {
    case chart
    case artistDetail(Int)
    case trackDetail(Int)
    case search(String)
    case playlists
    case playlistDetail(Int)
    case albumDetail(Int)
    case tracksOfArtist(Int)
    case albumsOfArtist(Int)
}

extension EndPointItems : EndPointType {
    var path: String {
        switch self {
        case .artistDetail(let artistID):
            return "artist/\(artistID)"
        case .tracksOfArtist(let artistID):
            return "artist/\(artistID)/top?limit=50"
        case .playlistDetail(let playlistID):
            return "playlist/\(playlistID)"
        case .chart:
            return "chart/"
        case .trackDetail(let trackId):
            return "track/\(trackId)"
        case .search(let query):
            if let queryString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                return "search?q=\(queryString)"
            }else {
                return "search?q="
            }
        case .albumsOfArtist(let artistID):
            return "artist/\(artistID)/albums"
        case .playlists:
            return "chart/0/playlists"
        case .albumDetail(let id):
            return "album/\(id)"
        }
    }
    
    var baseUrl: String {
        "https://api.deezer.com/"
    }
    
    var url: URL? {
        get {
            return URL(string: "\(baseUrl)\(path)")
        }
    }
    
    var method: httpMethods {
        return .get
    }
    
    
}
