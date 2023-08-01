//
//  HomeTitleLabel.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit

class HomeTitleLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: "Rockwell", size: 30)
        self.textColor = .white
        self.textAlignment = .left
        self.text = "Artists"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
