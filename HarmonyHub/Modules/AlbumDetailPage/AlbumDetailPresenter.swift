//
//  AlbumDetailPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit


final class AlbumDetailPresente : AlbumDetailPresenterInterface {
    
    private weak var view : AlbumDetailViewInterface?
    private let interactor : AlbumDetailInteractorInterface
    private let router : AlbumDetailRouterInterface
    private let selectedAlbumID : Int
    
    init(selectedAlbumID : Int,view : AlbumDetailViewInterface,interactor : AlbumDetailInteractorInterface,router : AlbumDetailRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.selectedAlbumID = selectedAlbumID
    }
    
    func viewDidLoad() {
        interactor.fetchAlbumDetail(id: self.selectedAlbumID)
    }
    func handleViewOutput(output: AlbumDetailViewOutput) {
        
    }
    func handleInteractorOutput(output: AlbumDetailInteractorOutput) {
        switch output {
        case .albumLoaded(let album):
            view?.handlePresenterOutput(output: .albumLoaded(album))
        }
    }
}
