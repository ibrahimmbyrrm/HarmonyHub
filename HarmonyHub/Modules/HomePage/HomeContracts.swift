//
//  HomeContracts.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 31.07.2023.
//

import Foundation
import UIKit

protocol HomeViewInterface {
    var presenter : HomePresenterInterface? {get set}
}
protocol HomePresenterInterface {
    
}
protocol HomeInteractorInterface {
    var presenter : HomePresenterInterface? {get set}
}
protocol HomeRouterInterface {
    var view : UIViewController? {get set}
}
