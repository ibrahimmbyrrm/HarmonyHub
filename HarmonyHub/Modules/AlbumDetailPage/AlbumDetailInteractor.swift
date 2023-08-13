//
//  AlbumDetailInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation



final class AlbumDetailInteractor : AlbumDetailInteractorInterface {
    
    var service : NetworkService
    var audioService : AudioService
    weak var presenter: AlbumDetailPresenterInterface?
    
    init(service : NetworkService,audioService : AudioService) {
        self.service = service
        self.audioService = audioService
    }
    
    func fetchAlbumDetail(id: Int) {
        service.fetchData(type: EndPointItems<BaseAlbum>.albumDetail(id)) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let baseAlbum):
                self.presenter?.handleInteractorOutput(output: .albumLoaded(baseAlbum))
            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: - PreviewInteractor Methods
    func setupAudioServiceDelegate(delegate: PreviewPlayableCellClient) {
        self.audioService.previewPlayerDelegate = delegate
    }

    func playPreview(url: URL) {
        audioService.insertQueueAndPlay(url: url)
    }
    
    func stopPreview() {
        audioService.stopAndClearQueue()
    }
    
    
    
}
