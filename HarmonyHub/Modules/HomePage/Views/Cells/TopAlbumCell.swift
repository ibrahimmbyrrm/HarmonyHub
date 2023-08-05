//
//  TopAlbumCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import UIKit

class TopAlbumCell: UICollectionViewCell {
    
    lazy var albumImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var albumName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 12)
        label.textColor = .white
        return label
    }()
    lazy var artistName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 10)
        label.textColor = .gray
        return label
    }()
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with album : AlbumsDatum) {
        DispatchQueue.main.async {
            self.albumImage.setImage(with: album.coverMedium ?? "")
            self.albumName.text = album.title
            self.artistName.text = album.artist?.name
        }
    }
    
    private func addSubviews() {
        [albumImage,albumName,artistName].forEach { v in
            stackView.addArrangedSubview(v)
        }
        addSubview(stackView)
    }
    
    func setup() {
        albumImage.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width)
            make.height.equalTo(140)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
    }
    
}
