//
//  AlbumDetailBuilder.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit

typealias AlbumDetailViewInterfaceAndController = UIViewController & AlbumDetailViewInterface

final class AlbumDetailBuilder {
    
    static func buildModule(albumId : Int) -> UIViewController {
        let view : AlbumDetailViewInterfaceAndController = AlbumDetailController()
        var interactor : AlbumDetailInteractorInterface  = AlbumDetailInteractor(service: NetworkManager(),audioService: AudioManager())
        var router : AlbumDetailRouterInterface = AlbumDetailRouter()
        let presenter : AlbumDetailPresenterInterface = AlbumDetailPresente(selectedAlbumID: albumId, view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.view = view
        interactor.presenter = presenter
        return view
    }
}
