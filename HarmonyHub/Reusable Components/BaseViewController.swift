//
//  BaseViewController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import UIKit

class BaseViewController<T : UIView> : UIViewController {
    var rootView : T {
        view as! T
    }
    override func loadView() {
        view = T()
    }
}
