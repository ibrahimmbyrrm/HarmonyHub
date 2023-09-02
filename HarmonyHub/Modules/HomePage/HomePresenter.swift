//
//  HomePresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation

enum HomeInteractorOutput {
    case chart(Welcome)
}

final class HomePresenter : HomePresenterInterface {
    private weak var view : HomeViewInterface?
    private var interactor : HomeInteractorInterface
    private var router : HomeRouterInterface
    
    init(view: HomeViewInterface, interactor: HomeInteractorInterface, router: HomeRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        self.view?.setDelegates()
        self.view?.setupNavigationController()
        self.view?.setupMediaButtonsActions()
        self.view?.getData()
    }
    
    func handleInteractorOutput(chart : Welcome) {
        guard let albums = chart.albums?.data,let artists = chart.artists?.data,let tracks = chart.tracks?.data else {return}
        view?.handlePresenterOutput(output: .albumLoaded(albums))
        view?.handlePresenterOutput(output: .artistsLoaded(artists))
        view?.handlePresenterOutput(output: .tracksLoaded(tracks))
    }
    
    func handleViewOutput(output: HomeViewToPresenterOutput) {
        switch output {
        case .loadData:
            interactor.fetchChart()
        case .goToAlbumDetail(let albumId):
            router.navigateTo(to: .toAlbum(albumId))
        case .goToArtistDetail(let artistID):
            router.navigateTo(to: .toArtist(artistID))
        case .goToTrackDetail(let trackId):
            router.navigateTo(to: .toTrack(trackId))
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
