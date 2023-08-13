//
//  ArtistDetailBuilder.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation
import UIKit


typealias ArtistDetailViewInterfaceAndController = UIViewController & ArtistDetailViewInterface

final class ArtistDetailBuilder {
    
    static func buildModule(artistID : Int) -> UIViewController {
        var view : ArtistDetailViewInterfaceAndController = ArtistDetailController()
        var router : ArtistDetailRouterInterface = ArtistDetailRouter()
        var interactor : ArtistDetailInteractorInterface = ArtistDetailInteractor(service: NetworkManager())
        let presenter : ArtistDetailPresenterInterface = ArtistDetailPresenter(view: view, router: router, interactor: interactor, selectedID: artistID)
        view.presenter = presenter
        router.view = view
        interactor.presenter = presenter
        return view
    }
}
