//
//  PopularTracksCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import UIKit

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(track : TracksDatum) {
        DispatchQueue.main.async {
            self.artistLabel.text = track.artist.name
            self.trackTitle.text = track.title
            self.trackImageView.setImage(with: track.album.coverMedium)
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
    }
    
    private func addSubviews() {
        [trackImageView,trackTitle,artistLabel].forEach { v in
            addSubview(v)
        }
    }
    
}
