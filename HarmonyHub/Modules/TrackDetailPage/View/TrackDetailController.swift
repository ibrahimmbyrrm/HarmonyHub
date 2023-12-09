//
//  TrackDetailController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

final class TrackDetailController : BaseViewController<TrackDetailView> {
    
    var presenter: TrackDetailPresenterInterface?
    var trackDetail : TrackDetail! {
        didSet {
            self.reloadUI()
        }
    }
    //MARK: - UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        presenter = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.handleTrackPreviewOutput(output: .stopPreview)
    }
    //MARK: - Initial Methods
    func getData() {
        presenter?.handleViewOutput(output: .fetchData)
    }
    func setDelegates() {
        rootView.controllerDelegate = self
        rootView.artistDetailContainer.delegate = self
    }
    func setupNavigationController() {
        view.backgroundColor = .black
        title = PageTitles.trackDetailTitle
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
//MARK: - Interface Methods
extension TrackDetailController : TrackDetailViewInterface, PlayPreviewButtonDelegate, ArtistDetailGestureInterface {
    
    func artistContainerDidTapped() {
        presenter?.handleViewOutput(output: .goToArtist(self.trackDetail.artist.id))
    }
    
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(_):
            guard let url = trackDetail.preview.convertToUrl() else {return}
            presenter?.handleTrackPreviewOutput(output: .playPreview(url))
        case .stop:
            presenter?.handleTrackPreviewOutput(output: .stopPreview)
            
        }
    }
    
    func handlePresenterOutput(output: TrackDetailPresenterToViewOutput) {
        switch output {
        case .trackDetailDidFetch(let trackDetail):
            self.trackDetail = trackDetail
        }
    }
    
    func reloadUI() {
        rootView.setupUI(track: self.trackDetail)
    }
}
