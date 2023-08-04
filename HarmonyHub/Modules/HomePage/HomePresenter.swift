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
    private var view : HomeViewInterface
    private var interactor : HomeInteractorInterface
    private var router : HomeRouterInterface
    
    init(view: HomeViewInterface, interactor: HomeInteractorInterface, router: HomeRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.setDelegates()
        view.setupNavigationController()
        view.setupMediaButtonsActions()
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
            interactor.playPreview(url: track.previewURL)
        case .stopPreview:
            interactor.stopPreview()
        }
        
    }
    
    func handleInteractorOutput(chart : Welcome) {
        view.handlePresenterOutput(output: .albumLoaded(chart.albums.data))
        view.handlePresenterOutput(output: .artistsLoaded(chart.artists.data))
        view.handlePresenterOutput(output: .tracksLoaded(chart.tracks.data))
    }
}
