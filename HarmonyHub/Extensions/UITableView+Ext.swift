//
//  UITableView+Ext.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    func asSearchResultCell() -> SearchResultCell {
        if let newCell = self as? SearchResultCell {
            return newCell
        }else {
            return SearchResultCell()
        }
    }
}
