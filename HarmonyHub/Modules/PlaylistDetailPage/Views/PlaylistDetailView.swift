//
//  PlaylistDetailView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation
import UIKit



class PlaylistDetailView : UIView, PreviewPlayerViewClient {
    
    lazy var scrollView = UIScrollView()
    lazy var activityIndicator = UIActivityIndicatorView()
    lazy var playlistCover : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    lazy var playlistTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    lazy var playlistDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 16)
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    lazy var tracksTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TrackListCell.self, forCellReuseIdentifier: TrackListCell.identifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    lazy var favoriteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemIndigo
        button.backgroundColor = .black
        button.addTarget(nil, action: #selector(println), for: .touchUpInside)
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubviews()
        setupActivityIndicatorConstraints()
        setupPlaylistCoverConstraints()
        setupPlaylistTitleConstraints()
        setupScrollViewConstraints()
        setupFavoriteButtonConstraints()
        playlistDescriptionConstraints()
        setupTracksTableViewCosntraints()
        self.scrollView.isHidden = true
        self.activityIndicator.startAnimating()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func println() {
        if favoriteButton.imageView?.image == UIImage(systemName: "heart") {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        addSubview(activityIndicator)
        scrollView.addSubview(favoriteButton)
        scrollView.addSubview(playlistCover)
        scrollView.addSubview(playlistTitle)
        scrollView.addSubview(playlistDescription)
        scrollView.addSubview(tracksTableView)
    }
    
    func restartTrackCellPreviewButton(url: URL) {
        tracksTableView.visibleCells.filter({$0.asTrackListCell().ownerTrack.previewURL != url}).forEach( {
            $0.asTrackListCell().playPreviewButton.setTitle(PreviewButtonIcons.play, for: .normal)
                $0.asTrackListCell().isPlaying = false
        })
    }
    private func setupFavoriteButtonConstraints() {
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalTo(self.snp.trailing).inset(5)
            make.centerY.equalTo(self.playlistTitle.snp.centerY)
        }
    }
    
    func configureUI(with playlist : DetailedPlaylist) {
        DispatchQueue.main.async {
            self.playlistCover.setImage(with: playlist.pictureBig)
            self.playlistTitle.text = playlist.title
            self.playlistDescription.text = playlist.description
            self.scrollView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }

    private func setupActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
    
    private func setupTracksTableViewCosntraints() {
        tracksTableView.snp.makeConstraints { make in
            make.width.equalTo(self.scrollView.snp.width)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.top.equalTo(self.playlistDescription.snp.bottom).offset(10)
            make.height.equalTo(2500)
        }
    }
    
    private func setupScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 2790)
    }
    
    private func playlistDescriptionConstraints() {
        playlistDescription.snp.makeConstraints { make in
            make.leading.equalTo(self.scrollView.snp.leading).offset(5)
            make.top.equalTo(self.playlistTitle.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(self.scrollView.snp.width)
        }
    }
    
    private func setupPlaylistTitleConstraints() {
        playlistTitle.snp.makeConstraints { make in
            make.leading.equalTo(self.scrollView.snp.leading).offset(5)
            make.height.equalTo(30)
            make.top.equalTo(self.playlistCover.snp.bottom).offset(5)
            make.width.equalTo(300)
        }
    }
    
    private func setupPlaylistCoverConstraints() {
        playlistCover.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.top.equalTo(self.scrollView.snp.top).offset(5)
        }
    }
}
