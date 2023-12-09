//
//  UIView+Ext.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 10.12.2023.
//

import UIKit

extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
