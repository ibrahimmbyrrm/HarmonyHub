//
//  PlaylistDetailContracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 6.08.2023.
//

import Foundation
import UIKit

protocol PlaylistDetailViewInterface : AnyObject {
    var presenter : PlaylistDetailPresenterInterface? {get set}
    func handlePresenterOutput(output : PlaylistDetailPresenterToViewOutput)
    func setupNavigationController()
    func setDelegates()
    func getDetails()
}
protocol PlaylistDetailPresenterInterface : AnyObject,PreviewPlayerPresenterClient {
    func handleInteractorOutput(output : PlaylistDetailInteractorToPresenterOutput)
    func handleViewOutput(output : PlaylistDetailViewToPresenterOutput)
    func viewDidLoad()
}
protocol PlaylistDetailInteractorInterface : PreviewPlayerInteractorClient {
    var presenter : PlaylistDetailPresenterInterface? {get set}
    func fetchDetails(id : Int)
}
protocol PlaylistDetailRouterInterface {
    var view : UIViewController? {get set}
    
    func navigateToTrack(with trakId : Int)
}
enum PlaylistDetailViewToPresenterOutput {
    case loadPlaylistDetails
    case trackSelected(Int)
}
enum PlaylistDetailPresenterToViewOutput {
    case playlistDetailsLoaded(DetailedPlaylist)
}
enum PlaylistDetailInteractorToPresenterOutput {
    case playlistDownloaded(DetailedPlaylist)
}
