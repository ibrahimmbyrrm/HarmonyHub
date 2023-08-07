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
        interactor.fetchDetails(id: self.selectedID)
        view?.setDelegates()
        view?.setupNavigationController()
    }
    
    func handleTrackPreviewOutput(output : TrackPreviewOutput) {
        switch output {
        case .playPreview(let track):
            guard let url = track.previewURL else {return}
            interactor.playPreview(url: url)
        case .stopPreview:
            interactor.stopPreview()
        }
    }
    
    func handleViewOutput(output: PlaylistDetailViewToPresenterOutput) {
        switch output {
        case .loadPlaylistDetails(let id):
            interactor.fetchDetails(id: id)
        }
    }
    func handleInteractorOutput(output: PlaylistDetailInteractorToPresenterOutput) {
        switch output {
        case .playlistDownloaded(let detailedPlaylist):
            print(detailedPlaylist.pictureMedium)
            self.view?.handlePresenterOutput(output: .playlistDetailsLoaded(detailedPlaylist))
        }
    }
}
