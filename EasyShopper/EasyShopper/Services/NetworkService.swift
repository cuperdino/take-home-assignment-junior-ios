//
//  NetworkService.swift
//  EasyShopper
//
//  Created by Sabahudin Kodro on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol NetworkServiceProtocol {
    func callApi<T: Codable>(endpoint: Endpoint, returnType: T.Type) -> Promise<T>
}

class NetworkService: NetworkServiceProtocol {
    func callApi<T: Codable>(endpoint: Endpoint, returnType: T.Type) -> Promise<T> {
        return Promise { seal in
            AF.request(endpoint).responseJSON {
                response in
                switch response.result {
                case .success:
                    do {
                        let data = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                        seal.fulfill(data)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                    print(error)
                }
            }
        }
    }
}


enum Endpoint: Alamofire.URLRequestConvertible {
    case getProducts
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .getProducts:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba")!)
        }
    }
}
