//
//  ArtistDetailConstracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 13.08.2023.
//

import Foundation
import UIKit

protocol ArtistDetailPresenterInterface {
    func viewDidLoad()
    func handleViewOutput(output : ArtistDetailViewOutput)
    func handleInteractorOutput(output : ArtistDetailInteractorOutput)
}
protocol ArtistDetailViewInterface : AnyObject {
    var presenter : ArtistDetailPresenterInterface? {get set}
    func getDeta()
}
protocol ArtistDetailInteractorInterface {
    var presenter : ArtistDetailPresenterInterface? {get set}
    func fetchArtistProfile(with id : Int)
    func fetchTracks(with id : Int)
}
protocol ArtistDetailRouterInterface {
    var view : UIViewController? {get set}
}
enum ArtistDetailPresenterToInteractorOutput {
    
}
enum ArtistDetailPresenterToViewOutput {
    
}
enum ArtistDetailInteractorOutput {
    
}
