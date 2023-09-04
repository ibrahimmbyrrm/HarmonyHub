//
//  PlaylistDetailRouter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation
import UIKit

final class PlaylistDetailRouter : PlaylistDetailRouterInterface {
    unowned var view: UIViewController?
    
    func navigateToTrack(with trakId: Int) {
        let destination = TrackDetailBuilder.buildModule(with: trakId)
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}
