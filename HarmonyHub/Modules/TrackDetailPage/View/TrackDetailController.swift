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
    }
    func setupNavigationController() {
        print("setup navigation controller called")
    }
}

extension TrackDetailController : TrackDetailViewInterface {
    func handlePresenterOutput(output: TrackDetailPresenterToViewOutput) {
        switch output {
        case .trackDetailDidFetch(let trackDetail):
            self.trackDetail = trackDetail
        }
    }
}
