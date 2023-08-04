//
//  PlaylistsCell.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 3.08.2023.
//

import Foundation
import UIKit

class PopularPlaylistsCell : UICollectionViewCell {
    
    lazy var playlistImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlaylistImageViewConstraints() {
        
    }
}
