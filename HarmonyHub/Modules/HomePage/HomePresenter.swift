//
//  HomePresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation

final class HomePresenter : HomePresenterInterface {
    private var view : HomeViewInterface
    private var interactor : HomeInteractorInterface
    private var router : HomeRouterInterface
    
    init(view: HomeViewInterface, interactor: HomeInteractorInterface, router: HomeRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
