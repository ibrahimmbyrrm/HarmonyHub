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
    case goToAlbumDetail(Int)
    case goToArtistDetail(Int)
    case goToTrackDetail(Int)
}

enum HomeInteractorOutput {
    case chart(Welcome)
}

enum TrackPreviewOutput {
    case playPreview(URL)
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
    func getData()
}
protocol HomePresenterInterface : AnyObject,PreviewPlayerPresenterClient {
    func handleInteractorOutput(chart : Welcome)
    func handleViewOutput(output : HomeViewToPresenterOutput)
    func viewDidLoad()
}
protocol HomeInteractorInterface : PreviewPlayerInteractorClient {
    var presenter : HomePresenterInterface? {get set}
    func fetchChart()
}
protocol HomeRouterInterface {
    var view : UIViewController? {get set}
    
    func navigateTo(to rotate : HomeRouterNavigations)
}
enum HomeRouterNavigations {
    case toAlbum(Int)
    case toTrack(Int)
    case toArtist(Int)
}
