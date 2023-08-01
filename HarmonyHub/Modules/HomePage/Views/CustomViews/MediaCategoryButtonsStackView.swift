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
    
    var buttons : [MediaCategoryButton] {
        return [musicButton,albumButton,podcastButton,playlistsButton]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alignment = .leading
        spacing = 15
        [musicButton, albumButton, podcastButton, playlistsButton].forEach { v in
            addArrangedSubview(v)
        }
    }
    
    func changeButtonColors(type : MediaType) {
        [musicButton, albumButton, podcastButton, playlistsButton].forEach { v in
            v.backgroundColor = .darkGray
        }
        switch type{
        case .album:
            albumButton.backgroundColor = .systemIndigo
        case .music:
            musicButton.backgroundColor = .systemIndigo
        case.playlist:
            playlistsButton.backgroundColor = .systemIndigo
        case.podcast:
            podcastButton.backgroundColor = .systemIndigo
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
