//
//  TrackDetailPresenter.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

final class TrackDetailPresenter : TrackDetailPresenterInterface {
    
    private weak var view : TrackDetailViewInterface?
    private let router : TrackDetailRouterInterface
    private let interactor : TrackDetailInteractorInterface
    private var selectedTracksId : Int
    
    init(selectedTracksId : Int,view : TrackDetailViewInterface,router : TrackDetailRouterInterface,interactor : TrackDetailInteractorInterface) {
        self.selectedTracksId = selectedTracksId
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.getData()
        view?.setDelegates()
        view?.setupNavigationController()
    }
    
    func handleInteractorOutput(output: TrackDetailInteractorToPresenterOutput) {
        switch output {
        case .detailsDidFetch(let trackDetail):
            view?.handlePresenterOutput(output: .trackDetailDidFetch(trackDetail))
        }
    }
    
    func handleViewOutput(output: TrackDetailViewToPresenterOutput) {
        switch output {
        case .fetchData:
            interactor.fetchDetails(trackID: self.selectedTracksId)
        case .goToArtist(let artistID):
            router.navigateToArtist(artistId: artistID)
        }
    }
    
    func transferPreviewPlayableCellToInteractor(delegate: PreviewPlayableCellClient) {
        
    }
    func handleTrackPreviewOutput(output: TrackPreviewOutput) {
        switch output {
        case .playPreview(let url):
            interactor.playPreview(url: url)
        case .stopPreview:
            interactor.stopPreview()
        }
    }
}
