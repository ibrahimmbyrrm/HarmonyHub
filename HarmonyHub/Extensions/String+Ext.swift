//
//  String+Ext.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 2.08.2023.
//

import Foundation

extension String {
    func convertToUrl() -> URL? {
        guard let url = URL(string: self) else  {
            return nil
        }
        return url
    }
}
