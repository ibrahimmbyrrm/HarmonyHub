//
//  ArtistDetailPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation

final class ArtistDetailPresenter : ArtistDetailPresenterInterface {
    
    private weak var view : ArtistDetailViewInterface?
    private let router : ArtistDetailRouterInterface
    private let interactor : ArtistDetailInteractorInterface
    private let selectedID : Int
    
    init(view: ArtistDetailViewInterface, router: ArtistDetailRouterInterface, interactor: ArtistDetailInteractorInterface,selectedID : Int) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.selectedID = selectedID
    }
    
    func viewDidLoad() {
        view?.getDeta()
    }
    
    func handleViewOutput(output: ArtistDetailViewOutput) {
        switch output {
        case .fetchDetails:
            interactor.fetchArtistProfile(with: self.selectedID)
        }
    }
    func handleInteractorOutput(output: ArtistDetailInteractorOutput) {
        
    }
    
}
