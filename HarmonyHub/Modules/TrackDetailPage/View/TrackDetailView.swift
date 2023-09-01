//
//  TrackDetailView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

final class TrackDetailView : UIView {
    
    lazy var trackCover : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var playButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(PreviewButtonIcons.play, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .black
        button.tintColor = .systemIndigo
        button.layer.borderColor = UIColor.systemIndigo.cgColor
        button.layer.borderWidth = 4
        button.addTarget(self, action: #selector(playPreviewButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var trackInfoStackView = TrackInformationStackView()
    
    var controllerDelegate: PlayPreviewButtonDelegate?
    var ownerTrack: TracksDatum!
    var isPlaying: Bool = false
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupTrackCoverConstraints()
        setupTrackInfoConstraints()
        setupPlayButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(track : TrackDetail) {
        trackInfoStackView.setupUI(track: track)
        self.trackCover.setImage(with: track.album.coverBig)
    }

    private func addSubviews() {
        [trackCover,trackInfoStackView,playButton].forEach({ self.addSubview($0) })
    }
    private func setupTrackCoverConstraints() {
        trackCover.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.height.equalTo(200)
        }
    }
    private func setupTrackInfoConstraints() {
        trackInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.top.equalTo(self.trackCover.snp.bottom).offset(10)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(75)
        }
    }
    private func setupPlayButtonConstraints() {
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(5)
            make.width.height.equalTo(50)
            make.centerY.equalTo(self.trackInfoStackView.snp.centerY)
        }
    }
}
extension TrackDetailView : PreviewPlayableClient {
    @objc func playPreviewButtonTapped() {
        if isPlaying {
            playButton.setTitle(PreviewButtonIcons.play, for: .normal)
            isPlaying = false
        }else {
            self.isPlaying = true
            playButton.setTitle(PreviewButtonIcons.pause, for: .normal)
        }
    }
}
