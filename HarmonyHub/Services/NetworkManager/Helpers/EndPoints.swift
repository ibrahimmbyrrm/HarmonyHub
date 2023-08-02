//
//  EndPoints.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation

protocol EndPointType {
    var path : String {get}
    var baseUrl : String {get}
    var url : URL? {get}
    var method : httpMethods {get}
}

enum EndPointItems<T : Decodable> {
    case chart
}

extension EndPointItems : EndPointType {
    var path: String {
        switch self {
        case .chart:
            return "chart/"
        }
    }
    
    var baseUrl: String {
        "https://api.deezer.com/"
    }
    
    var url: URL? {
        get {
            return URL(string: "\(baseUrl)\(path)")
        }
    }
    
    var method: httpMethods {
        return .get
    }
    
    
}
