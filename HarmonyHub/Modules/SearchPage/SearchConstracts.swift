//
//  SearchConstracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 4.08.2023.
//

import Foundation
import UIKit

enum SearchViewToPresenterOutput {
    
}

enum SearchInteractorToPresenterOutput {
    
}

protocol SearchViewInterface {
    func setupNavigationController()
}
protocol SearchPresenterInterface {
    func viewDidLoad()
    func handleViewOutput(output : SearchViewToPresenterOutput)
    func handleInteractorOutput(output : SearchInteractorToPresenterOutput)
}
protocol SearchInteractorInterface {
    var presenter : SearchPresenterInterface {get set}
}
protocol SearchRouterInterface {
    var view : UIViewController? {get set}
}
