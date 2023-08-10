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
}
protocol PlaylistDetailPresenterInterface : AnyObject,PreviewPresenter {
    func handleInteractorOutput(output : PlaylistDetailInteractorToPresenterOutput)
    func handleViewOutput(output : PlaylistDetailViewToPresenterOutput)
    func viewDidLoad()
}
protocol PlaylistDetailInteractorInterface : PreviewInteractor {
    var presenter : PlaylistDetailPresenterInterface? {get set}
    func fetchDetails(id : Int)
}
protocol PlaylistDetailRouterInterface {
    var view : UIViewController? {get set}
}
enum PlaylistDetailViewToPresenterOutput {
    case loadPlaylistDetails(Int)
}
enum PlaylistDetailPresenterToViewOutput {
    case playlistDetailsLoaded(DetailedPlaylist)
}
enum PlaylistDetailInteractorToPresenterOutput {
    case playlistDownloaded(DetailedPlaylist)
}
