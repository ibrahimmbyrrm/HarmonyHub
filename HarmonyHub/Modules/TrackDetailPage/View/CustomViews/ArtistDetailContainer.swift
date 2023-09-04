//
//  ArtistDetailContainer.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.09.2023.
//

import Foundation
import UIKit

class ArtistDetailContainer : UIView {
    
    lazy var ownerArtistImageView = RoundedImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    lazy var ownerArtistName : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: FontNames.ariel, size: 16)
        return label
    }()
    
    weak var delegate : ArtistDetailGestureInterface?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(containerDidTapped))
        self.addGestureRecognizer(gesture)
    }
    
    private func addSubviews() {
        [ownerArtistImageView,ownerArtistName].forEach({ self.addSubview($0) })
    }
    
    private func setupLayout() {
        ownerArtistImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.height.width.equalTo(70)
            make.centerY.equalTo(self.snp.centerY)
        }
        ownerArtistName.snp.makeConstraints { make in
            make.leading.equalTo(ownerArtistImageView.snp.trailing).offset(5)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(20)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    
    @objc func containerDidTapped() {
        delegate?.artistContainerDidTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
