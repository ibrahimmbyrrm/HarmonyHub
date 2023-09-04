//
//  SearchBuilder.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit

typealias SearchViewInterfaceAsController = SearchViewInterface & UIViewController

final class SearchBuilder {
    
    static func buildModule() -> UIViewController {
        var interactor : SearchInteractorInterface = SearchInteractor(service: NetworkManager(),audioService: AudioManager())
        let view : SearchViewInterfaceAsController = SearchController()
        var router : SearchRouterInterface = SearchRouter()
        let presenter : SearchPresenterInterface = SearchPresenter(interactor: interactor, view: view, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        router.view = view
        return view
    }
    
}
