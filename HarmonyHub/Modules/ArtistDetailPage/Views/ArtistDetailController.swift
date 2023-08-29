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
        rootView.tracksTableView.delegate = self
        rootView.tracksTableView.dataSource = self
    }
    
    func setupNavigationController() {
        print("navigation controller setup called")
    }
    
}

extension ArtistDetailController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rootView.tracksTableView.dequeueReusableCell(withIdentifier: AlbumDetailModuleConstants.trackCell, for: indexPath) as! TrackListCell
        cell.configure(track: trackList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ArtistDetailController : ArtistDetailViewInterface {
    
    func getDeta() {
        presenter?.handleViewOutput(output: .fetchDetails)
    }
    
    func reloadUI() {
        guard let url = artistDetail.picture_big else {return}
        print(url)
        rootView.artistImageView.setImage(with: url)
        rootView.artistStatsStackView.setupStats(artist: artistDetail, trackCount: trackList.count)
        print(trackList.map({$0.title}))
        print(albums.map({$0.title}))
        print(trackList.count)
        rootView.tracksTableView.reloadData()
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

