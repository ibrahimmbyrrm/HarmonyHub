//
//  ArtistDetailController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//
import Foundation
import UIKit

enum ArtistDetailViewOutput {
    case fetchDetails
}

final class ArtistDetailController : BaseViewController<ArtistDetailView> {
    
    var artistDetail : ArtistDetail!
    var trackList : [TracksDatum] = []
    var albums : [BaseAlbum] = []
    
    var presenter: ArtistDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func setDelegates() {
        print("set delegates called")
    }
    
    func setupNavigationController() {
        print("navigation controller setup called")
    }
    
}

extension ArtistDetailController : ArtistDetailViewInterface {
    
    func getDeta() {
        presenter?.handleViewOutput(output: .fetchDetails)
    }
    
    func reloadUI() {
        print(artistDetail.name)
        print(trackList.map({$0.title}))
        print(albums.map({$0.title}))
    }
    
    func handlePresenterOutput(with output: ArtistDetailPresenterToViewOutput) {
        switch output {
        case .artistLoaded(let artistDetail):
            self.artistDetail = artistDetail
        case .tracksLoaded(let tracks):
            self.trackList = tracks
        case .albumsLoaded(let albums):
            self.albums = albums
        }
    }
}

