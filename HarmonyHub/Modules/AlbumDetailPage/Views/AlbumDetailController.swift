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
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.handleTrackPreviewOutput(output: .stopPreview)
    }
    
    func getDetails() {
        presenter?.handleViewOutput(output: .fetchDetails)
    }
    
    func setupNavigationController() {
        title = PageTitles.albumDetailTitle
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setDelegates() {
        rootView.tracksTableView.delegate = self
        rootView.tracksTableView.dataSource = self
        rootView.delegate = self
    }
    
}
extension AlbumDetailController : UITableViewDelegate, UITableViewDataSource,PlayPreviewButtonDelegate {
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(let index):
            guard let list = self.album.tracks,let index else {return}
            let itemAtIndex = list.data[index.row]
            guard let itemUrl = itemAtIndex.previewURL else {return}
            self.presenter?.handleTrackPreviewOutput(output: .playPreview(itemUrl))
        case .stop:
            self.presenter?.handleTrackPreviewOutput(output: .stopPreview
            )
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trackId = album.tracks?.data[indexPath.row].id else {return}
        presenter?.handleViewOutput(output: .goToTrack(trackId))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let album = album {
            guard let itemCount = album.tracks?.data.count else {return 0}
            return itemCount
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackListCell.identifier, for: indexPath) as! TrackListCell
        guard let list = self.album.tracks else {return UITableViewCell()}
        presenter?.transferPreviewPlayableCellToInteractor(delegate: cell as PreviewPlayableCellClient)
        cell.configure(track: list.data[indexPath.row])
        cell.setupIndexPathAndDelegate(viewDelegate: self.rootView, delegate: self, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension AlbumDetailController : AlbumDetailViewInterface, ArtistDetailGestureInterface {
    
    func artistContainerDidTapped() {
        guard let artistId = album.artist?.id else {return}
        presenter?.handleViewOutput(output: .goToArtist(artistId))
    }
    
    func handlePresenterOutput(output: AlbumDetailPresenterToViewOutput) {
        switch output {
        case .albumLoaded(let baseAlbum):
            self.album = baseAlbum
            rootView.configureUI(with: baseAlbum)
            rootView.tracksTableView.reloadData()
        }
    }
    
}
