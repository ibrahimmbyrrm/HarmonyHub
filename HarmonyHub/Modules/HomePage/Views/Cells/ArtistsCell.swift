//
//  ArtistsCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import UIKit

class ArtistsCell: UICollectionViewCell {
    
    lazy var artistImage  = RoundedImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var artistNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupArtistImageViewConstraints()
        setupArtistNameLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(artist : ArtistElement) {
        guard let image = artist.pictureSmall else {return}
        self.artistImage.setImage(with: image)
        self.artistNameLabel.text = artist.name
    }
    
    private func addSubviews() {
        addSubview(artistImage)
        addSubview(artistNameLabel)
    }
    
    private func setupArtistImageViewConstraints() {
        artistImage.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
    }
    private func setupArtistNameLabelConstraints() {
        artistNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(15)
            make.bottom.equalTo(self.snp.bottom).inset(4)
            make.top.equalTo(artistImage.snp.bottom).offset(2)
        }
    }
}
