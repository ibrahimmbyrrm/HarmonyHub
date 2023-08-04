//
//  HomeContracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import UIKit

enum HomePresenterToViewOutput {
    case albumLoaded([AlbumsDatum])
    case tracksLoaded([TracksDatum])
    case artistsLoaded([ArtistElement])
}
enum HomeViewToPresenterOutput {
    case loadData
    
}

enum HomeViewTrackPreviewOutput {
    case playPreview(TracksDatum)
    case stopPreview
}

protocol HomeViewInterface : AnyObject {
    var albums : [AlbumsDatum] {get set}
    var artists : [ArtistElement] {get set}
    var tracks : [TracksDatum] {get set}
    var presenter : HomePresenterInterface? {get set}
    
    func handlePresenterOutput(output : HomePresenterToViewOutput)
    func setupNavigationController()
    func setupMediaButtonsActions()
    func setDelegates()
}
protocol HomePresenterInterface {
    func handleInteractorOutput(chart : Welcome)
    func handleViewOutput(output : HomeViewToPresenterOutput)
    func handleTrackPreviewOutput(output : HomeViewTrackPreviewOutput)
    func viewDidLoad()
}
protocol HomeInteractorInterface {
    var presenter : HomePresenterInterface? {get set}
    var service : NetworkService {get set}
    func fetchChart()
    func playPreview(url : URL)
    func stopPreview()
}
protocol HomeRouterInterface {
    var view : UIViewController? {get set}
}
