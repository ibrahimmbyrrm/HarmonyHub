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
    
    var presenter: TrackDetailPresenterInterface?
    
    func fetchDetails(trackID: Int) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        service.fetchData(type: EndPointItems<TrackDetail>.trackDetail(trackID)) { result in
            defer { dispatchGroup.leave()}
            switch result {
            case .success(let trackDetails):
                self.presenter?.handleInteractorOutput(output: .detailsDidFetch(trackDetails))
            case .failure(let error):
                print(error)
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.presenter?.interactorDownloadProcessFinished()
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
