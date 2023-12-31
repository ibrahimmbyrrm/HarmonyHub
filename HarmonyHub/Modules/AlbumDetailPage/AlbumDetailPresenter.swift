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
    private var interactor : AlbumDetailInteractorInterface
    private let router : AlbumDetailRouterInterface
    private let selectedAlbumID : Int
    
    init(selectedAlbumID : Int,view : AlbumDetailViewInterface,interactor : AlbumDetailInteractorInterface,router : AlbumDetailRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.selectedAlbumID = selectedAlbumID
    }
    
    func viewDidLoad() {
        view?.setDelegates()
        view?.setupNavigationController()
        view?.getDetails()
    }
    
    func handleViewOutput(output: AlbumDetailViewOutput) {
        switch output {
        case .fetchDetails:
            interactor.fetchAlbumDetail(id: self.selectedAlbumID)
        case .goToTrack(let trackId):
            router.navigateTo(destination: .goToTrack(trackId))
        case .goToArtist(let artistId):
            router.navigateTo(destination: .goToArtist(artistId))
        }
    }
    
    func handleInteractorOutput(output: AlbumDetailInteractorOutput) {
        switch output {
        case .albumLoaded(let album):
            view?.handlePresenterOutput(output: .albumLoaded(album))
        }
    }
    //MARK: - PreviewPresenter Methods
    func transferPreviewPlayableCellToInteractor(delegate: PreviewPlayableCellClient) {
        interactor.setupAudioServiceDelegate(delegate: delegate)
    }
    
    func handleTrackPreviewOutput(output: TrackPreviewOutput) {
        switch output {
        case .playPreview(let url):
            self.interactor.playPreview(url: url)
        case .stopPreview:
            self.interactor.stopPreview()
        }
    }
    
    
}
