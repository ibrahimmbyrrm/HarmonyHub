//
//  MediaCategoryButton.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import UIKit

enum MediaType{
    case music
    case podcast
    case playlist
    case album
}

class MediaCategoryButton : UIButton {
    
    var mediaType : MediaType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(title : String,medieType : MediaType) {
        self.init(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        self.mediaType = medieType
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        self.layer.cornerRadius = 21
        self.layer.borderWidth = 0.5
        self.backgroundColor = .darkGray
        self.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
