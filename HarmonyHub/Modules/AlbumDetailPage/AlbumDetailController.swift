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
        rootView.tracksTableView.delegate = self
        rootView.tracksTableView.dataSource = self
    }
    
}
extension AlbumDetailController : UITableViewDelegate, UITableViewDataSource,PreviewButtonDelegate {
    func handleCellsAudioOutput(output: previewPlayerOutput) {
        switch output {
        case .play(let index):
            let itemAtIndex = self.album.tracks.data [index.row]
            self.presenter?.handleTrackPreviewOutput(output: .playPreview(itemAtIndex))
        case .stop:
            self.presenter?.handleTrackPreviewOutput(output: .stopPreview
            )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let album = album {
            return album.tracks.data.count
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackListCell
        presenter?.implementPreviewPlayableDelegate(delegate: cell as PreviewPlayable)
        cell.configure(track: self.album.tracks.data[indexPath.row])
        cell.setupIndexPathAndDelegate(viewDelegate: self.rootView, delegate: self, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension AlbumDetailController : AlbumDetailViewInterface {
    
    func handlePresenterOutput(output: AlbumDetailPresenterToViewOutput) {
        switch output {
        case .albumLoaded(let baseAlbum):
            self.album = baseAlbum
            rootView.configureUI(with: baseAlbum)
            rootView.tracksTableView.reloadData()
        }
    }
    
}
