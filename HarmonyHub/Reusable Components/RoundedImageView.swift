//
//  RoundedImageView.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.09.2023.
//

import Foundation
import UIKit

class RoundedImageView : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 35
        self.clipsToBounds = true
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
