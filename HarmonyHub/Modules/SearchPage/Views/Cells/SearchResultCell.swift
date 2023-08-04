//
//  TrackCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit

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
    
    lazy var infoStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackName,artistName])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 2
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupTrackImageViewConstraints()
        setupTrackNameLabelConstraints()
        //setupArtistNameLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(track : TracksDatum) {
        guard let name = track.title,let image = track.album?.coverMedium,let artist = track.artist?.name else {return}
        DispatchQueue.main.async {
            self.artistName.text = artist
            self.trackName.text = name
            self.trackImage.setImage(with: image)
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
            make.height.equalTo(45)
            make.width.equalTo(200)
        }
    }
    
    private func setupArtistNameLabelConstraints() {
        artistName.snp.makeConstraints { make in
            make.top.equalTo(self.trackName.snp.bottom).offset(2)
            make.leading.equalTo(self.trackImage.snp.trailing).offset(2)
            make.height.equalTo(20)
        }
    }
    
    private func addSubviews() {
        [infoStackView,trackImage].forEach { v in
            addSubview(v)
        }
    }
}
