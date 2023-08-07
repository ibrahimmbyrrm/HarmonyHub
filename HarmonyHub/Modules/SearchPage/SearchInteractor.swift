//
//  SearchInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation

final class SearchInteractor : SearchInteractorInterface {
    
    weak var presenter: SearchPresenterInterface?
    var service : NetworkService
    
    init(service : NetworkService) {
        self.service = service
    }
    
    func fetchPlaylists() {
        service.fetchData(type: EndPointItems<Playlists>.playlists) { result in
            switch result {
            case .success(let platlistData):
                self.presenter?.handleInteractorOutput(output: .playlistsLoaded(platlistData.data))
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
    
    func fetchQueryResults(_ query : String) {
        service.fetchData(type: EndPointItems<Tracks>.search(query)) { result in
            switch result {
            case .success(let trackData):
                self.presenter?.handleInteractorOutput(output: .queryResultsLoaded(trackData.data))
            case .failure(let error):
                print(error)
            }
        }
    }
}
