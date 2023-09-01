//
//  HomeRouter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import UIKit

final class HomeRouter : HomeRouterInterface{
    unowned var view: UIViewController?
    
    func navigateTo(to rotate: HomeRouterNavigations) {
        var destination : UIViewController?
        
        switch rotate {
        case .toAlbum(let albumId):
            destination = AlbumDetailBuilder.buildModule(albumId: albumId)
        case .toArtist(let artistId):
            destination = ArtistDetailBuilder.buildModule(artistID: artistId)
        case .toTrack(let trackId):
            destination = TrackDetailBuilder.buildModule(with: trackId)
        }
        
        guard let destination else {return}
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}
