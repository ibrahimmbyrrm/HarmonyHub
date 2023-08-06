//
//  PlaylistDetailPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation

final class PlaylistDetailPresenter : PlaylistDetailPresenterInterface {
    private weak var view : PlaylistDetailViewInterface?
    private let interactor : PlaylistDetailInteractorInterface
    private let router : PlaylistDetailRouterInterface
    
    init(view : PlaylistDetailViewInterface,interactor : PlaylistDetailInteractorInterface,router : PlaylistDetailRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func handleViewOutput(output: PlaylistDetailViewToPresenterOutput) {
        
    }
    func handleInteractorOutput(output: PlaylistDetailInteractorToPresenterOutput) {
        
    }
}
