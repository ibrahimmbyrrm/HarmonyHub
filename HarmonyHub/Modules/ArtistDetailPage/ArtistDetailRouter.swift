//
//  ArtistDetailRouter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation
import UIKit

final class ArtistDetailRouter : ArtistDetailRouterInterface {
    weak var view: UIViewController?
    
    func navigateToTrack(trackID: Int) {
        let destination = TrackDetailBuilder.buildModule(with: trackID)
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}
