//
//  TrackInformationStackView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

class TrackInformationStackView : UIStackView {
    lazy var trackTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 28)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    lazy var artistsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    lazy var trackTypeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.ariel, size: 14)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [trackTitle,artistsLabel,trackTypeLabel].forEach({ self.addArrangedSubview($0) })
        self.distribution = .equalSpacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(track : TrackDetail) {
        self.trackTitle.text = track.title
        self.trackTypeLabel.text = "\(track.releaseDate.components(separatedBy: "-").first!) - \(track.type.capitalized)"
        self.artistsLabel.text = track.contributors.first?.name
    }
}

