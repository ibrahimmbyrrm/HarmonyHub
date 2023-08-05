//
//  HomeInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import Alamofire

final class HomeInteractor : HomeInteractorInterface {
    weak var presenter: HomePresenterInterface?
    var service: NetworkService
    
    init(service : NetworkService) {
        self.service = service
    }
    
    func fetchChart() {
        service.fetchData(type: EndPointItems<Welcome>.chart) { result in
            switch result {
            case .success(let chart):
                self.presenter?.handleInteractorOutput(chart: chart)
            case .failure(let error):
                print(error)
            }
        }
    }
    func playPreview(url : URL) {
        AudioManager.shared.insertQueueAndPlay(url: url)
    }
    func stopPreview() {
        AudioManager.shared.stopAndClearQueue()
    }
}
