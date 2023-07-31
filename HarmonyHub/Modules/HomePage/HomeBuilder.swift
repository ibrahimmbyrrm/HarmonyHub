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
        var view : HomeViewControllerInterface = HomeView()
        var interactor : HomeInteractorInterface = HomeInteractor()
        var router : HomeRouterInterface = HomeRouter()
        let presenter : HomePresenterInterface = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
}
