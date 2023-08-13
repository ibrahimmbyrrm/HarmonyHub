//
//  PlaylistDetailInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation

final class PlaylistDetailInteractor : PlaylistDetailInteractorInterface {
    
    var service : NetworkService
    weak var presenter: PlaylistDetailPresenterInterface?
    var audioService: AudioService
    
    init(service : NetworkService,audioService : AudioService) {
        self.service = service
        self.audioService = audioService
    }
    
    func fetchDetails(id : Int) {
        service.fetchData(type: EndPointItems<DetailedPlaylist>.playlistDetail(id)) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let detailedPlaylist):
                self.presenter?.handleInteractorOutput(output: .playlistDownloaded(detailedPlaylist))
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
