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
    case trackDetail(Int)
    case search(String)
    case playlists
}

extension EndPointItems : EndPointType {
    var path: String {
        switch self {
        case .chart:
            return "chart/"
        case .trackDetail(let trackId):
            return "track/\(trackId)"
        case .search(let query):
            return "search?q=\(query)"
        case .playlists:
            return "chart/0/playlists"
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
