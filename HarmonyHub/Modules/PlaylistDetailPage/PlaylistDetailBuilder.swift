//
//  PlaylistDetailBuilder.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation
import UIKit

typealias PlaylistDetailViewAndController = UIViewController & PlaylistDetailViewInterface

final class PlaylistDetailBuilder {
    
    static func buildModule(playlistID : Int) -> UIViewController {
        let view : PlaylistDetailViewAndController = PlaylistDetailController()
        var router : PlaylistDetailRouterInterface = PlaylistDetailRouter()
        var interactor : PlaylistDetailInteractorInterface = PlaylistDetailInteractor(service: NetworkManager())
        let presenter : PlaylistDetailPresenterInterface = PlaylistDetailPresenter(id: playlistID,view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.view = view
        interactor.presenter = presenter
        return view
    }
}
