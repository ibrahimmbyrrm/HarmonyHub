//
//  AlbumDetailView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit

class AlbumDetailView : UIView, PreviewPlayerViewClient {
    
    lazy var albumCover : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var  albumNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    lazy var albumOwnerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    lazy var tracksTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.isScrollEnabled = true
        tableView.register(TrackListCell.self, forCellReuseIdentifier: TrackListCell.identifier)
        return tableView
    }()
    
    weak var delegate : ArtistDetailGestureInterface?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        addScrollViewSubviews()
        setupTracksTableViewConstraints()
        setupAlbumCoverConstraints()
        setupAlbumNameLabelConstraints()
        setupAlbumOwnerConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(artistNameTapped))
        self.albumOwnerLabel.addGestureRecognizer(gesture)
    }
    
    @objc func artistNameTapped() {
        delegate?.artistContainerDidTapped()
    }
    
    func configureUI(with album : BaseAlbum) {
        DispatchQueue.main.async {
            self.albumCover.setImage(with: album.coverMedium)
            self.albumNameLabel.text = album.title
            if let name = album.artist?.name {
                self.albumOwnerLabel.text = name
            }
        }
    }
    
    func restartTrackCellPreviewButton(url: URL) {
        tracksTableView.visibleCells.filter({$0.asTrackListCell().ownerTrack.previewURL != url}).forEach( {
            $0.asTrackListCell().playPreviewButton.setTitle(PreviewButtonIcons.play, for: .normal)
            $0.asTrackListCell().isPlaying = false
        })
    }
    
    private func addScrollViewSubviews() {
        [albumCover,albumNameLabel,albumOwnerLabel,tracksTableView,tracksTableView].forEach({ self.addSubview($0) })
    }
    
    private func setupTracksTableViewConstraints() {
        tracksTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(albumOwnerLabel.snp.bottom).offset(10)
        }
    }
    
    private func setupAlbumOwnerConstraints() {
        albumOwnerLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.height.equalTo(20)
            make.top.equalTo(self.albumNameLabel.snp.bottom).offset(2)
        }
    }

    private func setupAlbumNameLabelConstraints() {
        albumNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.top.equalTo(self.albumCover.snp.bottom).offset(5)
            make.height.equalTo(60)
            make.width.equalToSuperview()
        }
    }
    
    private func setupAlbumCoverConstraints() {
        albumCover.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
        }
    }
    
}
