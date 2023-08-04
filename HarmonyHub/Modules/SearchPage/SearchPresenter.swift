//
//  SearchPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation

final class SearchPresenter : SearchPresenterInterface {
    
    private var interactor : SearchInteractorInterface
    private var view : SearchViewInterface
    private var router : SearchRouterInterface
    
    init(interactor : SearchInteractorInterface,view : SearchViewInterface,router : SearchRouterInterface) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    
}
