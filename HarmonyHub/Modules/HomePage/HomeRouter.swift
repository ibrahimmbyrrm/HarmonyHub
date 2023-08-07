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
        switch rotate {
        case .toAlbum(let albumId):
            let detailPage = AlbumDetailBuilder.buildModule(albumId: albumId)
            view?.navigationController?.pushViewController(detailPage, animated: true)
        case .toArtist(let artistId):
            print("going to artist with \(artistId) id")
        case .toTrack(let trackId):
            print("going to track with \(trackId) id")
        }
    }
}
