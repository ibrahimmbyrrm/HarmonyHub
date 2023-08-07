//
//  PlaylistDetailController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation
import UIKit

final class PlaylistDetailController : BaseViewController<PlaylistDetailView> {
    
    var presenter: PlaylistDetailPresenterInterface?
    var playlist : DetailedPlaylist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func setupNavigationController() {
        title = "Playlist"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setDelegates() {
        rootView.tracksTableView.delegate = self
        rootView.tracksTableView.dataSource = self
    }
}
extension PlaylistDetailController : PlaylistDetailViewInterface {
    
    func handlePresenterOutput(output: PlaylistDetailPresenterToViewOutput) {
        switch output {
        case .playlistDetailsLoaded(let playlist):
            self.playlist = playlist
            rootView.configureUI(with: playlist)
            rootView.tracksTableView.reloadData()
        }
    }
    
}
extension PlaylistDetailController : UITableViewDelegate,UITableViewDataSource, PreviewButtonDelegate {
    
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(let indexPath):
            presenter?.handleTrackPreviewOutput(output: .playPreview(playlist.tracks.data[indexPath.row]))
        case .stop:
            presenter?.handleTrackPreviewOutput(output: .stopPreview)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let playlist = playlist {
            return playlist.tracks.data.count
        }else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackListCell
        let itemAtIndex = playlist.tracks.data[indexPath.row]
        cell.configure(track: itemAtIndex)
        cell.setupIndexPathAndDelegate(viewDelegate : rootView,delegate: self, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}