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
}
protocol PlaylistDetailPresenterInterface : AnyObject {
    func handleInteractorOutput(output : PlaylistDetailInteractorToPresenterOutput)
    func handleViewOutput(output : PlaylistDetailViewToPresenterOutput)
    func viewDidLoad()
}
protocol PlaylistDetailInteractorInterface {
    var presenter : PlaylistDetailPresenterInterface? {get set}
}
protocol PlaylistDetailRouterInterface {
    var view : UIViewController? {get set}
}
enum PlaylistDetailViewToPresenterOutput {
    
}
enum PlaylistDetailPresenterToViewOutput {
    
}
enum PlaylistDetailInteractorToPresenterOutput {
    
}
