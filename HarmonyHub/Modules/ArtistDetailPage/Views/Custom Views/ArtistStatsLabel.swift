//
//  ArtistStatsLabel.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 29.08.2023.
//

import Foundation
import UIKit

final class ArtistStatsLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .gray
        self.font = UIFont(name: FontNames.ariel, size: 20)
        self.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
