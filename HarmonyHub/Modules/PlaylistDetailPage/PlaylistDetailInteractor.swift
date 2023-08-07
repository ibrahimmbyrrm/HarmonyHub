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
    
    init(service : NetworkService) {
        self.service = service
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
    func playPreview(url: URL) {
        AudioManager.shared.insertQueueAndPlay(url: url)
    }
    func stopPreview() {
        AudioManager.shared.stopAndClearQueue()
    }
}
