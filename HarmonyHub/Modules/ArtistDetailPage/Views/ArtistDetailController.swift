//
//  ArtistDetailController.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation
import UIKit

enum ArtistDetailViewOutput {
    case fetchDetails
}

final class ArtistDetailController : BaseViewController<ArtistDetailView> , ArtistDetailViewInterface {
    
    var presenter: ArtistDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func getDeta() {
        presenter?.handleViewOutput(output: .fetchDetails)
    }
    
    
}

