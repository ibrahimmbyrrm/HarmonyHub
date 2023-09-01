//
//  Interactor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

final class TrackDetailInteractor : TrackDetailInteractorInterface {
    private let service : NetworkService
    
    init(service : NetworkService) {
        self.service = service
    }
    
    var presenter: TrackDetailPresenterInterface?
    
    func fetchDetails(trackID: Int) {
        service.fetchData(type: EndPointItems<TrackDetail>.trackDetail(trackID)) { result in
            switch result {
            case .success(let trackDetails):
                self.presenter?.handleInteractorOutput(output: .detailsDidFetch(trackDetails))
            case .failure(let error):
                print(error)
            }
        }
    }
}
