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
        var view : PlaylistDetailViewAndController = PlaylistDetailController()
        var router : PlaylistDetailRouterInterface = PlaylistDetailRouter()
        var interactor : PlaylistDetailInteractorInterface = PlaylistDetailInteractor()
        let presenter : PlaylistDetailPresenterInterface = PlaylistDetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        view.title = "\(playlistID)"
        router.view = view
        interactor.presenter = presenter
        return view
    }
}
