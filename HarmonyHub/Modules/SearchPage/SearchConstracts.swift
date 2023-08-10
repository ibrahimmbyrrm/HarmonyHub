//
//  SearchConstracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit

enum SearchViewToPresenterOutput {
    case loadPlaylists
    case fetchSearchResults(String)
    case platlistSelected(PlaylistsDatum)
    case trackSelected(TracksDatum)
}

enum SearchInteractorToPresenterOutput {
    case playlistsLoaded([PlaylistsDatum])
    case queryResultsLoaded([TracksDatum])
}

enum SearchPresenterToViewOutput {
    case playlistsLoaded([PlaylistsDatum])
    case queryResultsLoaded([TracksDatum])
}

protocol SearchViewInterface : AnyObject {
    var presenter : SearchPresenterInterface? {get set}
    func setupNavigationController()
    func setDelegates()
    func handlePresenterOutput(output : SearchPresenterToViewOutput)
}
protocol SearchPresenterInterface : AnyObject,PreviewPresenter {
    func viewDidLoad()
    func handleViewOutput(output : SearchViewToPresenterOutput)
    func handleInteractorOutput(output : SearchInteractorToPresenterOutput)
}
protocol SearchInteractorInterface : PreviewInteractor {
    var presenter : SearchPresenterInterface? {get set}
    func fetchPlaylists()
    func fetchQueryResults(_ query : String)
}
protocol SearchRouterInterface {
    var view : UIViewController? {get set}
    
    func navigateTo(to rotate : SearchRouterNavigations)
}

enum SearchRouterNavigations {
    case toPlatlist(Int)
    case toTrack(Int)
}
