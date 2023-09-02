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
    var trackDetail : TrackDetail!
    //MARK: - UIViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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
    }
    func setupNavigationController() {
        print("setup navigation controller called")
    }
}
//MARK: - Interface Methods
extension TrackDetailController : TrackDetailViewInterface, PlayPreviewButtonDelegate {
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
