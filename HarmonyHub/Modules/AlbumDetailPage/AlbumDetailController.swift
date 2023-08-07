//
//  AlbumDetailController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit

final class AlbumDetailController : BaseViewController<AlbumDetailView> {
    
    var presenter: AlbumDetailPresenterInterface?
    var album : BaseAlbum!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}
extension AlbumDetailController : AlbumDetailViewInterface {
    
    func handlePresenterOutput(output: AlbumDetailPresenterToViewOutput) {
        switch output {
        case .albumLoaded(let baseAlbum):
            self.album = baseAlbum
            rootView.configureUI(with: baseAlbum)
        }
    }
    
}
