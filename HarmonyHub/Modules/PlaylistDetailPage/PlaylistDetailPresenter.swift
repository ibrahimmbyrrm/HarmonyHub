//
//  PlaylistDetailPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation

final class PlaylistDetailPresenter : PlaylistDetailPresenterInterface {
    private var view : PlaylistDetailViewInterface?
    private var interactor : PlaylistDetailInteractorInterface
    private let router : PlaylistDetailRouterInterface
    private var selectedID : Int
    
    init(id : Int,view : PlaylistDetailViewInterface,interactor : PlaylistDetailInteractorInterface,router : PlaylistDetailRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.selectedID = id
    }
    
    func viewDidLoad() {
        view?.setDelegates()
        view?.setupNavigationController()
        view?.getDetails()
    }
    
    func handleViewOutput(output: PlaylistDetailViewToPresenterOutput) {
        switch output {
        case .loadPlaylistDetails:
            interactor.fetchDetails(id: self.selectedID)
        }
    }
    
    func handleInteractorOutput(output: PlaylistDetailInteractorToPresenterOutput) {
        switch output {
        case .playlistDownloaded(let detailedPlaylist):
            print(detailedPlaylist.pictureMedium)
            self.view?.handlePresenterOutput(output: .playlistDetailsLoaded(detailedPlaylist))
        }
    }
    //MARK: - PreviewPresenter Methods
    func transferPreviewPlayableCellToInteractor(delegate: PreviewPlayableCellClient) {
        interactor.setupAudioServiceDelegate(delegate: delegate)
    }
    
    func handleTrackPreviewOutput(output : TrackPreviewOutput) {
        switch output {
        case .playPreview(let url):
            interactor.playPreview(url: url)
        case .stopPreview:
            interactor.stopPreview()
        }
    }
    
}
