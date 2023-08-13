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
    var audioService: AudioService
    
    init(service : NetworkService,audioService : AudioService) {
        self.service = service
        self.audioService = audioService
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
    //MARK: - PreviewInteractor Methods
    func setupAudioServiceDelegate(delegate: PreviewPlayableCellClient) {
        self.audioService.previewPlayerDelegate = delegate
    }
    
    func playPreview(url : URL) {
        audioService.insertQueueAndPlay(url: url)
    }
    func stopPreview() {
        audioService.stopAndClearQueue()
    }
}
