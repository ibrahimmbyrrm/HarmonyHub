//
//  UICollectionView+Ext.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 3.08.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    func asTrackCell() -> PopularTracksCell {
        if let newCell = self as? PopularTracksCell {
            return newCell
        }
        return PopularTracksCell()
    }
}
