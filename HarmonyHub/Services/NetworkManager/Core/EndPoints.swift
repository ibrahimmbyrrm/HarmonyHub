//
//  EndPoints.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import SwiftUI

struct BMIItem {
    let id = UUID()
    let date : Date?
    let result : Double
    
    var BMIResult : BMIType {
        switch result {
        case 0..<18.4:
            return BMIResults.underweight
        case 18.4..<24.9:
            return BMIResults.normal
        case 24.9..<39.9:
            return BMIResults.overweight
        default:
            return BMIResults.obese
        }
    }
}

protocol BMIType {
    var color : Color {get}
    var title : String {get}
}

enum BMIResults {
    case underweight
    case normal
    case overweight
    case obese
}

extension BMIResults : BMIType {
    var color: Color {
        switch self {
        case .normal:
            return .green
        case .underweight:
            return .blue
        case .overweight:
            return .orange
        case .obese:
            return .red
        }
    }
    
    var title: String {
        switch self {
        case .normal: "Normal"
        case .obese: "Obese"
        case .overweight: "Overweight"
        case .underweight: "Underweight"
        }
    }
}

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
            return "artist/\(artistID)/top?limit=100"
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
