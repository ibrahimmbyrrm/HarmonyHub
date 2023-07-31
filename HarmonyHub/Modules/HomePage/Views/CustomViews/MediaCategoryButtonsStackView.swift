//
//  MediaCategoryButtons.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import UIKit

class MediaButtonsStackView : UIStackView {
    
    var musicButton = MediaCategoryButton(title: "Music",medieType: .music)
    var albumButton = MediaCategoryButton(title: "Albums",medieType: .album)
    var podcastButton = MediaCategoryButton(title: "Podcasts",medieType: .podcast)
    var playlistsButton = MediaCategoryButton(title: "Playlists",medieType: .playlist)
    override init(frame: CGRect) {
           super.init(frame: frame)
           alignment = .leading
           spacing = 15
           [musicButton, albumButton, podcastButton, playlistsButton].forEach { v in
               v.setContentCompressionResistancePriority(.required, for: .horizontal) // Set compression resistance priority
               addArrangedSubview(v)
           }
       }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
