//
//  UITableView+Ext.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    func asTrackListCell() -> TrackListCell {
        if let newCell = self as? TrackListCell {
            return newCell
        }else {
            return TrackListCell()
        }
    }
}
