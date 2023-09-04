//
//  NetworkManager.swift
//  HarmonyHub
//
//  Created by İbrahim Bayram on 1.08.2023.
//

import Foundation
import Alamofire

protocol NetworkService {
    func fetchData<T : Decodable>(type : EndPointItems<T>,completion : @escaping (Result<T,AFError>)->Void)
}

final class NetworkManager: NetworkService {
    
    func fetchData<T>(type: EndPointItems<T>, completion: @escaping (Result<T, AFError>) -> Void) where T : Decodable {
        guard let url = type.url else {
            completion(.failure(AFError.invalidURL(url: "\(type.baseUrl)\(type.path)")))
            return
        }
        AF.request(url).responseDecodable(of : T.self) { response in
            switch response.result {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
