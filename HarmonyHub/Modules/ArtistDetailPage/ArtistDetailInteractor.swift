//
//  ArtistDetailInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation

final class ArtistDetailInteractor : ArtistDetailInteractorInterface {
    
    private var service : NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    var presenter: ArtistDetailPresenterInterface?
    
    func fetchArtistProfile(with id : Int) {
        service.fetchData(type: EndPointItems<ArtistDetail>.artistDetail(id)) { result in
            switch result {
            case .success(let artistDetail):
                //Transfet artist detail to presenter
                //call fetchTracks function to fetch all tracks of artist
                self.fetchTracks(with: id)
                print(artistDetail.name)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTracks(with id : Int) {
        service.fetchData(type: EndPointItems<Tracks>.tracksOfArtist(id)) { result in
            switch result {
            case .success(let tracks):
                print(tracks.data.first?.title)
            case .failure(let error):
                print(error)
            }
        }
    }
}
