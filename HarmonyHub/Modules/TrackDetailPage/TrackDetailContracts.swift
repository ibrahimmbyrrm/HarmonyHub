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
}
protocol TrackDetailPresenterInterface : AnyObject {
    func viewDidLoad()
    func handleViewOutput(output : TrackDetailViewToPresenterOutput)
    func handleInteractorOutput(output : TrackDetailInteractorToPresenterOutput)
}
protocol TrackDetailInteractorInterface {
    var presenter : TrackDetailPresenterInterface? {get set}
    func fetchDetails(trackID : Int)
}
protocol TrackDetailRouterInterface {
    var view : UIViewController? {get set}
}

enum TrackDetailViewToPresenterOutput {
    case fetchData
}
enum TrackDetailPresenterToViewOutput {
    case trackDetailDidFetch(TrackDetail)
}
enum TrackDetailInteractorToPresenterOutput {
    case detailsDidFetch(TrackDetail)
}
