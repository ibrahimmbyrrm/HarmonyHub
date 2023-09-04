//
//  AlbumDetailRouter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit

final class AlbumDetailRouter : AlbumDetailRouterInterface {
    unowned var view: UIViewController?
    
    func navigateTo(destination: AlbumRouterDestinations) {
        var dest : UIViewController?
        switch destination {
        case .goToArtist(let artistID):
            dest = ArtistDetailBuilder.buildModule(artistID: artistID)
        case .goToTrack(let trackId):
            dest = TrackDetailBuilder.buildModule(with: trackId)
        }
        guard let dest else {return}
        view?.navigationController?.pushViewController(dest, animated: true)
    }
}
