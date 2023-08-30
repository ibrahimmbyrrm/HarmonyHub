//
//  ArtistDetailInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation

final class ArtistDetailInteractor : ArtistDetailInteractorInterface {
    
    var audioService: AudioService
    private var service : NetworkService
    
    init(service: NetworkService,audioService : AudioService) {
        self.service = service
        self.audioService = audioService
    }
    
    var presenter: ArtistDetailPresenterInterface?
    
    func fetchArtistProfile(with id : Int) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        service.fetchData(type: EndPointItems<ArtistDetail>.artistDetail(id)) { [weak self] result in
            guard let self else {return}
            defer {dispatchGroup.leave()}
            switch result {
            case .success(let artistDetail):
                self.presenter?.handleInteractorOutput(output: .artistDetailsLoaded(artistDetail))
            case .failure(let error):
                print(error)
            }
        }
        dispatchGroup.enter()
        service.fetchData(type: EndPointItems<ArtistAlbumsBase>.albumsOfArtist(id)) { [weak self] result in
            guard let self else {return}
            defer {dispatchGroup.leave()}
            switch result {
            case .success(let artistAlbums):
                self.presenter?.handleInteractorOutput(output: .albumsOfArtistLoaded(artistAlbums.data))
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        service.fetchData(type: EndPointItems<Tracks>.tracksOfArtist(id)) { [weak self] result in
            guard let self else {return}
            defer {dispatchGroup.leave()}
            switch result {
            case .success(let tracks):
                self.presenter?.handleInteractorOutput(output: .tracksLoaded(tracks))
            case .failure(let error):
                print(error)
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.presenter?.interactorDidDownloadAllData()
        }
    }
    
    func setupAudioServiceDelegate(delegate: PreviewPlayableCellClient) {
        audioService.previewPlayerDelegate = delegate
    }
    
    func playPreview(url: URL) {
        audioService.insertQueueAndPlay(url: url)
    }
    
    func stopPreview() {
        audioService.stopAndClearQueue()
    }
    
}
