//
//  TrackCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit

typealias SearchViewPreviewDelegate = SearchController & PreviewButtonDelegate

class SearchResultCell : UITableViewCell {
    
    lazy var trackName : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Ariel", size: 30)
        return label
    }()
    lazy var artistName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ariel", size: 18)
        label.textColor = .gray
        return label
    }()
    lazy var trackImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var playPreviewButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .black
        button.tintColor = .systemIndigo
        button.addTarget(nil, action: #selector(playPreviewButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var infoStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackName,artistName])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.backgroundColor = .gray
        return stackView
    }()
    
    var delegate : SearchViewPreviewDelegate?
    var indexPath : IndexPath?
    
    var ownerTrack : TracksDatum!
    var isPlaying = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        addSubviews()
        setupTrackImageViewConstraints()
        setupTrackNameLabelConstraints()
        setupPlayPreviewButtonConstraints()
        listenToAudioManagerForMusicChanges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func listenToAudioManagerForMusicChanges() {
        AudioManager.shared.bind { url in
            if url != self.ownerTrack.previewURL {
                self.delegate?.rootView.restartTrackCellPreviewButton(url: url)
                self.isPlaying = false
            }
        }
    }
    
    func configure(track : TracksDatum) {
        guard let name = track.title,let image = track.album?.coverMedium,let artist = track.artist?.name else {return}
        DispatchQueue.main.async {
            self.artistName.text = artist
            self.trackName.text = name
            self.trackImage.setImage(with: image)
        }
    }
    
    @objc func playPreviewButtonTapped() {
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
    
    private func setupTrackImageViewConstraints() {
        trackImage.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(2)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(76)
            make.width.equalTo(76)
        }
    }
    
    private func setupTrackNameLabelConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.trackImage.snp.trailing).offset(10)
            make.trailing.equalTo(self.playPreviewButton.snp.leading).inset(-10)
            make.height.equalTo(45)
        }
    }
    
    private func setupArtistNameLabelConstraints() {
        artistName.snp.makeConstraints { make in
            make.top.equalTo(self.trackName.snp.bottom).offset(2)
            make.leading.equalTo(self.trackImage.snp.trailing).offset(2)
            make.height.equalTo(20)
        }
    }
    
    private func setupPlayPreviewButtonConstraints() {
        playPreviewButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(5)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    private func addSubviews() {
        [infoStackView,trackImage,playPreviewButton].forEach { v in
            addSubview(v)
        }
    }
}
