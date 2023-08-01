//
//  Helpers.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation

enum httpMethods : String{
    case get = "GET"
    case post = "POST"
}

enum httpError : String, Error {
    case noConnection = "There is a problem with your internet connection."
    case invalidURL = "The url which trying to be requested is invalid."
    case invalidData = "The url is working but the data it provides is invalid."
    case parsingError = "The url and the data is correct.The model trying to be decoded is at wrong format."
}

