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
        switch rotate {
        case .toPlatlist(let playlistId):
            view?.navigationController?.pushViewController(PlaylistDetailBuilder.buildModule(playlistID: playlistId), animated: true)
            print("Going to playlist which \(playlistId) id")
        case .toTrack(let trackId):
            print("Going to track which \(trackId) id")
        }
    }
}
