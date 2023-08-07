//
//  AlbumDetailView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit

class AlbumDetailView : UIView, PreviewPlayerViewInterface {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(with album : BaseAlbum) {
        
    }
    
    func restartTrackCellPreviewButton(url: URL) {
        
    }
    
}
