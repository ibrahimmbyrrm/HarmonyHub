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
        view?.setDelegates()
        view?.setupNavigationController()
        view?.getDeta()
    }
    
    func handleViewOutput(output: ArtistDetailViewOutput) {
        switch output {
        case .fetchDetails:
            interactor.fetchArtistProfile(with: self.selectedID)
        }
    }
    
    func handleTrackPreviewOutput(output: TrackPreviewOutput) {
        switch output {
        case .playPreview(let url):
            interactor.playPreview(url: url)
        case .stopPreview:
            interactor.stopPreview()
        }
    }
    
    func transferPreviewPlayableCellToInteractor(delegate: PreviewPlayableCellClient) {
        interactor.setupAudioServiceDelegate(delegate: delegate)
    }
    
    func interactorDidDownloadAllData() {
        self.view?.reloadUI()
    }
    
    func handleInteractorOutput(output: ArtistDetailInteractorOutput) {
        switch output {
        case .artistDetailsLoaded(let artistDetail):
            self.view?.handlePresenterOutput(with: .artistLoaded(artistDetail))
        case .tracksLoaded(let tracks):
            self.view?.handlePresenterOutput(with: .tracksLoaded(tracks.data))
        case .albumsOfArtistLoaded(let albums):
            self.view?.handlePresenterOutput(with: .albumsLoaded(albums))
        }
    }
    
}
