//
//  TrackCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit


class TrackListCell : UITableViewCell {
    
    static let identifier = "trackCell"
    
    //MARK: - UI Objects
    lazy var trackName : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: FontNames.ariel, size: 18)
        return label
    }()
    lazy var artistName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 16)
        label.textColor = .gray
        return label
    }()
    lazy var trackImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var infoStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackName,artistName])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.backgroundColor = .black
        return stackView
    }()
    lazy var playPreviewButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(PreviewButtonIcons.play, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.tintColor = .systemIndigo
        button.addTarget(self, action: #selector(playPreviewButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Preview Playable Variables
    weak var controllerDelegate : PlayPreviewButtonDelegate?
    weak var rootViewDelegate : PreviewPlayerViewClient?
    var indexPath : IndexPath?
    
    var ownerTrack : TracksDatum!
    var isPlaying = false
    
    //MARK: - Initialize Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        self.selectionStyle = .none
        addSubviews()
        setupTrackImageViewConstraints()
        setupStackViewConstraints()
        setupPlayPreviewButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup UI Methods
    func configure(track : TracksDatum) {
        guard let image = track.album.coverMedium,let artist = track.artist?.name else {return}
            self.artistName.text = artist
            self.trackName.text = track.title
            self.trackImage.setImage(with: image)
            self.ownerTrack = track
    }
    //MARK: - Layout Methods
    private func setupTrackImageViewConstraints() {
        trackImage.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(2)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(76)
            make.width.equalTo(76)
        }
    }
    
    private func setupStackViewConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.trackImage.snp.trailing).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(45)
        }
    }
    
    private func setupPlayPreviewButtonConstraints() {
        playPreviewButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(5)
            make.top.equalTo(self.snp.top).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    private func addSubviews() {
        [infoStackView,trackImage,playPreviewButton].forEach({ contentView.addSubview($0)})
        contentView.bringSubviewToFront(playPreviewButton)
    }
}
//MARK: - Preview Playable Methods
extension TrackListCell : PreviewPlayableCellClient {
    
    @objc func playPreviewButtonTapped() {
        if isPlaying {
            controllerDelegate?.handleCellsAudioOutput(output: .stop)
            playPreviewButton.setTitle(PreviewButtonIcons.play, for: .normal)
            isPlaying = false
        }else {
            guard let indexPath else {return}
            controllerDelegate?.handleCellsAudioOutput(output: .play(indexPath))
            self.isPlaying = true
            playPreviewButton.setTitle(PreviewButtonIcons.pause, for: .normal)
        }
    }
    
    func listenToAudioManagerForMusicChanges(url : URL) {
        guard url != self.ownerTrack.previewURL else {return}
        self.rootViewDelegate?.restartTrackCellPreviewButton(url: url)
        self.isPlaying = false
    }
    
    func setupIndexPathAndDelegate(viewDelegate : PreviewPlayerViewClient,delegate: PlayPreviewButtonDelegate, indexPath: IndexPath) {
        self.rootViewDelegate = viewDelegate
        self.controllerDelegate = delegate
        self.indexPath = indexPath
    }
}

