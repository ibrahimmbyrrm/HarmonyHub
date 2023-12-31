//
//  TrackDetailContracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.09.2023.
//

import Foundation
import UIKit

protocol TrackDetailViewInterface : AnyObject {
    var presenter : TrackDetailPresenterInterface? {get set}
    func handlePresenterOutput(output : TrackDetailPresenterToViewOutput)
    func getData()
    func setupNavigationController()
    func setDelegates()
    func reloadUI()
}
protocol TrackDetailPresenterInterface : AnyObject, PreviewPlayerPresenterClient {
    func viewDidLoad()
    func handleViewOutput(output : TrackDetailViewToPresenterOutput)
    func handleInteractorOutput(output : TrackDetailInteractorToPresenterOutput)
}
protocol TrackDetailInteractorInterface : PreviewPlayerInteractorClient {
    var presenter : TrackDetailPresenterInterface? {get set}
    func fetchDetails(trackID : Int)
}
protocol TrackDetailRouterInterface {
    var view : UIViewController? {get set}
    
    func navigateToArtist(artistId : Int)
}

protocol ArtistDetailGestureInterface : AnyObject {
    func artistContainerDidTapped()
}

enum TrackDetailViewToPresenterOutput {
    case fetchData
    case goToArtist(Int)
}
enum TrackDetailPresenterToViewOutput {
    case trackDetailDidFetch(TrackDetail)
}
enum TrackDetailInteractorToPresenterOutput {
    case detailsDidFetch(TrackDetail)
}
