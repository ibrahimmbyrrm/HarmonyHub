//
//  ArtistDetailConstracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation
import UIKit

protocol ArtistDetailPresenterInterface : AnyObject, PreviewPlayerPresenterClient {
    func viewDidLoad()
    func handleViewOutput(output : ArtistDetailViewOutput)
    func interactorDidDownloadAllData()
    func handleInteractorOutput(output : ArtistDetailInteractorOutput)
}
protocol ArtistDetailViewInterface : AnyObject {
    var presenter : ArtistDetailPresenterInterface? {get set}
    func getDeta()
    func setDelegates()
    func setupNavigationController()
    func reloadUI()
    func handlePresenterOutput(with output : ArtistDetailPresenterToViewOutput)
}
protocol ArtistDetailInteractorInterface : AnyObject, PreviewPlayerInteractorClient {
    var presenter : ArtistDetailPresenterInterface? {get set}
    func fetchArtistProfile(with id : Int)
}
protocol ArtistDetailRouterInterface {
    var view : UIViewController? {get set}
    func navigateToTrack(trackID : Int)
}
enum ArtistDetailViewOutput {
    case fetchDetails
    case goToTrack(Int)
}
enum ArtistDetailPresenterToInteractorOutput {
    
}
enum ArtistDetailPresenterToViewOutput {
    case artistLoaded(ArtistDetail)
    case tracksLoaded([TracksDatum])
    case albumsLoaded([BaseAlbum])
}
enum ArtistDetailInteractorOutput {
    case tracksLoaded(Tracks)
    case artistDetailsLoaded(ArtistDetail)
    case albumsOfArtistLoaded([BaseAlbum])
}
