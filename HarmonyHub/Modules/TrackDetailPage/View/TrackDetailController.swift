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
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func getData() {
        presenter?.handleViewOutput(output: .fetchData)
    }
    func setDelegates() {
        print("set delegates called")
        rootView.controllerDelegate = self
    }
    func setupNavigationController() {
        print("setup navigation controller called")
    }
}

extension TrackDetailController : TrackDetailViewInterface, PlayPreviewButtonDelegate {
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(_):
            if let trackDatum = trackDetail as? TracksDatum {
                presenter?.handleTrackPreviewOutput(output: .playPreview(trackDatum))
            }else {
                print("data convertation failed")
            }
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
