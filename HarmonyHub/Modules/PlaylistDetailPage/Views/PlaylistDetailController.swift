//
//  PlaylistDetailController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation
import UIKit

final class PlaylistDetailController : BaseViewController<PlaylistDetailView> {
    
    var presenter: PlaylistDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
extension PlaylistDetailController : PlaylistDetailViewInterface {
    
    func handlePresenterOutput(output: PlaylistDetailPresenterToViewOutput) {
        
    }
    
}
