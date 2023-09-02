//
//  SearchPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation

final class SearchPresenter : SearchPresenterInterface {
    
    private var interactor : SearchInteractorInterface
    private weak var view : (SearchViewInterface)?
    private var router : SearchRouterInterface
    
    init(interactor : SearchInteractorInterface,view : SearchViewInterface,router : SearchRouterInterface) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setDelegates()
        view?.setupNavigationController()
        view?.getPlaylists()
    }
    
    func handleInteractorOutput(output: SearchInteractorToPresenterOutput) {
        switch output {
        case .playlistsLoaded(let playlists):
            view?.handlePresenterOutput(output: .playlistsLoaded(playlists))
        case .queryResultsLoaded(let tracks):
            view?.handlePresenterOutput(output: .queryResultsLoaded(tracks))
        }
    }
    
    func handleViewOutput(output: SearchViewToPresenterOutput) {
        switch output {
        case .loadPlaylists:
            interactor.fetchPlaylists()
        case .fetchSearchResults(let queryString):
            interactor.fetchQueryResults(queryString)
        case .platlistSelected(let selectedPlaylist):
            router.navigateTo(to: .toPlatlist(selectedPlaylist.id))
        case .trackSelected(let selectedTrack):
            router.navigateTo(to: .toTrack(selectedTrack.id))
        }
    }
    //MARK: - PreviewPresenter Methods
    func handleTrackPreviewOutput(output : TrackPreviewOutput) {
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
    
}
