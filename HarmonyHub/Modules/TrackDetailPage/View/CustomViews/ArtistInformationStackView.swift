//
//  ArtistInformationStackView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

class ArtistInformationStackView : UIStackView {
    
    lazy var artistImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    lazy var artistNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 14)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubviews()
        setupStackViewProperties()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addArrangedSubviews() {
        [artistImageView,artistNameLabel].forEach({ self.addArrangedSubview($0) })
    }
    private func setupStackViewProperties() {
        self.distribution = .fill
        self.axis = .horizontal
        self.alignment = .leading
    }
    
}
