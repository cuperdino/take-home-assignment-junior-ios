//
//  NetworkService.swift
//  EasyShopper
//
//  Created by Sabahudin Kodro on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func callApi<T: Codable>(endpoint: Endpoint, returnType: T.Type)
}

class NetworkService: NetworkServiceProtocol {
    func callApi<T: Codable>(endpoint: Endpoint, returnType: T.Type) {
            AF.request(endpoint).responseJSON {
                response in
                    switch response.result {
                    case .success: print(response.value)
                    case .failure(let error): print(error)
            }
        }
    }
}


enum Endpoint: URLRequestConvertible {
    case getProducts
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .getProducts:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba")!)
        }
    }
}
