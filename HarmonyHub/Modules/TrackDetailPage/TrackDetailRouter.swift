//
//  TrackDetailRouter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

final class TrackDetailRouter : TrackDetailRouterInterface {
    unowned var view: UIViewController?
    
    func navigateToArtist(artistId: Int) {
        let destination = ArtistDetailBuilder.buildModule(artistID: artistId)
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}
