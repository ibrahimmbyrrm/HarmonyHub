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
        view?.setDelegates()
        view?.setupNavigationController()
        view?.setupMediaButtonsActions()
    }
    
    func handleViewOutput(output: HomeViewToPresenterOutput) {
        switch output {
        case .loadData:
            interactor.fetchChart()
        }
    }
    
    func handleTrackPreviewOutput(output : HomeViewTrackPreviewOutput) {
        switch output {
        case .playPreview(let track):
            guard let url = track.previewURL else {return}
            interactor.playPreview(url: url)
        case .stopPreview:
            interactor.stopPreview()
        }
        
    }
    
    func handleInteractorOutput(chart : Welcome) {
        guard let albums = chart.albums?.data,let artists = chart.artists?.data,let tracks = chart.tracks?.data else {return}
        view?.handlePresenterOutput(output: .albumLoaded(albums))
        view?.handlePresenterOutput(output: .artistsLoaded(artists))
        view?.handlePresenterOutput(output: .tracksLoaded(tracks))
    }
}
