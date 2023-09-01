//
//  SearchRouter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit

final class SearchRouter : SearchRouterInterface {
    unowned var view: UIViewController?
    
    func navigateTo(to rotate : SearchRouterNavigations) {
        var destination : UIViewController?
        
        switch rotate {
        case .toPlatlist(let playlistId):
            destination = PlaylistDetailBuilder.buildModule(playlistID: playlistId)
        case .toTrack(let trackId):
            destination = TrackDetailBuilder.buildModule(with: trackId)
        }
        guard let destination else {return}
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}
