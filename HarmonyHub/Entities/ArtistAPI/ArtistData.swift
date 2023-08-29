//
//  ArtistData.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation

struct ArtistDetail : Codable{
    let id: Int
    let name: String
    let link, share, picture: String
    let picture_small, picture_medium, picture_big, xl: String?
    let nb_album, nb_fan: Int?
    let radio: Bool
    let tracklist: String
    let type: String
}

struct ArtistAlbumsBase : Codable {
    let data : [BaseAlbum]
}

extension ArtistDetail {
    var popularity: String {
        guard let fans = self.nb_fan else { return "" }
        switch fans {
            case ..<5000:
                return "★"
            case 5000..<50000:
                return "★★"
            case 50000..<500000:
                return "★★★"
            case 500000..<1000000:
                return "★★★★★"
            default:
                return "★★★★★"
        }
    }
}

