//
//  PlaylistDetailInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation

final class PlaylistDetailInteractor : PlaylistDetailInteractorInterface {
    
    var service : NetworkService
    
    init(service : NetworkService) {
        self.service = service
    }
    weak var presenter: PlaylistDetailPresenterInterface?
    
    func fetchDetails(id : Int) {
        service.fetchData(type: EndPointItems<DetailedPlaylist>.playlistDetail(id)) { result in
            switch result {
            case .success(let detailedPlaylist):
                print(detailedPlaylist.description!)
            case .failure(let error):
                print(error)
            }
        }
    }
}
