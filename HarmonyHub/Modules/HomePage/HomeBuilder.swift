//
//  HomeBuilder.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//
import UIKit
import Foundation

typealias HomeViewControllerInterface = HomeViewInterface & UIViewController

final class HomeBuilder {
    
    static func buildModule() -> UIViewController {
        var view : HomeViewControllerInterface = HomeController()
        var interactor : HomeInteractorInterface = HomeInteractor(service: NetworkManager(),audioService: AudioManager())
        var router : HomeRouterInterface = HomeRouter()
        let presenter : HomePresenterInterface = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
}
