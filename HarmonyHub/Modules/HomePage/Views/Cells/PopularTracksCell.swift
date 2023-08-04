//
//  PopularTracksCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import UIKit

enum previewPlayerOutput {
    case stop
    case play(IndexPath)
}

protocol PreviewButtonDelegate {
    func handleCellsAudioOutput(output : previewPlayerOutput)
}

typealias PreviewButtonDelegateHomeController = PreviewButtonDelegate & HomeController

class PopularTracksCell: UICollectionViewCell {
    
    lazy var trackImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var trackTitle : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    lazy var artistLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    lazy var playPreviewButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.tintColor = .systemIndigo
        button.addTarget(nil, action: #selector(previewButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var delegate : PreviewButtonDelegateHomeController?
    var indexPath : IndexPath?
    
    var ownerTrack : TracksDatum!
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupImageViewConstraints()
        listenToAudioManagerForMusicChanges()
    }
    
    func listenToAudioManagerForMusicChanges() {
        AudioManager.shared.bind { url in
            if url != self.ownerTrack.previewURL {
                self.delegate?.rootView.restartTrackCellPreviewButton(url: url)
                self.isPlaying = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func previewButtonTapped() {
        if isPlaying {
            delegate?.handleCellsAudioOutput(output: .stop)
            playPreviewButton.setTitle("▶", for: .normal)
            isPlaying = false
        }else {
            guard let indexPath else {return}
            delegate?.handleCellsAudioOutput(output: .play(indexPath))
            self.isPlaying = true
            playPreviewButton.setTitle("▐▐", for: .normal)
        }
        
    }
    
    func configure(track : TracksDatum) {
        DispatchQueue.main.async {
            self.artistLabel.text = track.artist?.name
            self.trackTitle.text = track.title
            self.ownerTrack = track
            guard let image = track.album?.coverMedium else {return}
            self.trackImageView.setImage(with: image)
        }
    }
    
    private func setupImageViewConstraints() {
        trackImageView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(190)
        }
        trackTitle.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(trackImageView.snp.bottom).offset(3)
            make.height.equalTo(20)
        }
        artistLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(trackTitle.snp.bottom).offset(3)
            make.height.equalTo(20)
        }
        playPreviewButton.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.bottom.equalTo(self.trackImageView.snp.bottom).inset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    private func addSubviews() {
        [trackImageView,trackTitle,artistLabel,playPreviewButton].forEach { v in
            addSubview(v)
        }
    }
    
}
