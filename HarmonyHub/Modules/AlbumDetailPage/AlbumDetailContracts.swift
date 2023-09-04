//
//  AlbumDetailContracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 7.08.2023.
//

import Foundation
import UIKit

protocol AlbumDetailViewInterface : AnyObject {
    var presenter : AlbumDetailPresenterInterface? {get set}
    func handlePresenterOutput(output : AlbumDetailPresenterToViewOutput)
    func setDelegates()
    func getDetails()
    func setupNavigationController()
}
protocol AlbumDetailPresenterInterface : AnyObject,PreviewPlayerPresenterClient {
    func viewDidLoad()
    func handleViewOutput(output : AlbumDetailViewOutput)
    func handleInteractorOutput(output : AlbumDetailInteractorOutput)
}
protocol AlbumDetailInteractorInterface : PreviewPlayerInteractorClient {
    var presenter : AlbumDetailPresenterInterface? {get set}
    func fetchAlbumDetail(id : Int)
}
protocol AlbumDetailRouterInterface {
    var view : UIViewController? {get set}
    func navigateTo(destination : AlbumRouterDestinations)
}
enum AlbumDetailPresenterToViewOutput {
    case albumLoaded(BaseAlbum)
}
enum AlbumDetailInteractorOutput {
    case albumLoaded(BaseAlbum)
}
enum AlbumDetailViewOutput {
    case fetchDetails
    case goToTrack(Int)
    case goToArtist(Int)
}
enum AlbumRouterDestinations {
    case goToTrack(Int)
    case goToArtist(Int)
}
