//
//  Interactor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

final class TrackDetailInteractor : TrackDetailInteractorInterface {
    
    var audioService: AudioService
    private let service : NetworkService
    
    init(service : NetworkService,audioService : AudioService) {
        self.service = service
        self.audioService = audioService
    }
    
    weak var presenter: TrackDetailPresenterInterface?
    
    func fetchDetails(trackID: Int) {
        service.fetchData(type: EndPointItems<TrackDetail>.trackDetail(trackID)) { [weak self] result in
            switch result {
            case .success(let trackDetails):
                self?.presenter?.handleInteractorOutput(output: .detailsDidFetch(trackDetails))
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func setupAudioServiceDelegate(delegate: PreviewPlayableCellClient) {
    }
    
    func playPreview(url: URL) {
        audioService.insertQueueAndPlay(url: url)
    }
    
    func stopPreview() {
        audioService.stopAndClearQueue()
    }
    
    
}
