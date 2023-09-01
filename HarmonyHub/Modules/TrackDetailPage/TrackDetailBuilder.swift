//
//  TrackDetailBuilder.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

typealias TrackDetailViewAndInterface = UIViewController & TrackDetailViewInterface

final class TrackDetailBuilder {
    
    static func buildModule(with trackId : Int) -> UIViewController {
        
        let view : TrackDetailViewAndInterface = TrackDetailController()
        var interactor : TrackDetailInteractorInterface = TrackDetailInteractor(service: NetworkManager())
        var router : TrackDetailRouterInterface = TrackDetailRouter()
        let presenter : TrackDetailPresenterInterface = TrackDetailPresenter(selectedTracksId: trackId, view: view, router: router, interactor: interactor)
        view.presenter = presenter
        router.view = view
        interactor.presenter = presenter
        return view
    }
    
}
