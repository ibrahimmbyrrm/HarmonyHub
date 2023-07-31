//
//  UIImageView+Ext.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString : String) {
        guard let url = URL(string: urlString) else {return}
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
