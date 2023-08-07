//
//  AlbumDetailInteractor.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation



final class AlbumDetailInteractor : AlbumDetailInteractorInterface {
    
    var service : NetworkService
    
    init(service : NetworkService) {
        self.service = service
    }

    weak var presenter: AlbumDetailPresenterInterface?
    
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
    
}
