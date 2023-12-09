//
//  ArtistDetailsStackView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 29.08.2023.
//

import Foundation
import UIKit

final class ArtistDetailStackView : UIStackView {
    
    lazy var artistName : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: FontNames.ariel, size: 32)
        return label
    }()
    lazy var popularityLabel = ArtistStatsLabel()
    lazy var numberOfAlbumsLabel = ArtistStatsLabel()
    lazy var numberOfTracksLabel = ArtistStatsLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.distribution = .equalSpacing
        [artistName,popularityLabel,numberOfAlbumsLabel,numberOfTracksLabel].forEach({ self.addArrangedSubview($0) })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStats(artist : ArtistDetail,trackCount : Int) {
            self.artistName.text = artist.name
            self.popularityLabel.text = "Popularity \(artist.popularity)"
            self.numberOfAlbumsLabel.text = "\(artist.nb_album!) Albums"
            self.numberOfTracksLabel.text = "\(trackCount) Tracks"
    }
}
