//
//  NetworkManager.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import Alamofire

public typealias ResultBlock<T> = (Swift.Result<T, Error>) -> Void

protocol NetworkManaging {
    @discardableResult
    func request<T: Decodable>(_ type: T.Type,
                               endpoint: Endpoint,
                               completion: @escaping ResultBlock<T>) -> DataRequest?
}

class NetworkManager: NetworkManaging {
    private var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    @discardableResult
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint, completion: @escaping ResultBlock<T>) -> DataRequest? {
        do {
            let urlRequest = try endpoint.asURLRequest()
            return sessionManager.request(urlRequest)
                .validate()
                .responseJSON(completionHandler: { [weak self] (dataResponse) in
                    guard let `self` = self else {
                        completion(.failure(NetworkError.unknown))
                        return
                    }
                    guard dataResponse.result.isSuccess else {
                        completion(.failure(dataResponse.error ?? NetworkError.unknown))
                        return
                    }
                    
                    if "String" is T {
                        if let data = dataResponse.data, let strResult = String(data: data, encoding: .utf8) {
                            completion(.success(strResult as! T))
                        } else {
                            completion(.failure(NetworkError.dataNotAvailable))
                        }
                    } else {
                        self.decode(type, data: dataResponse.data, completion: completion)
                    }
                })
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
    private func decode<T: Decodable>(_ type: T.Type, data: Data?, completion: @escaping ResultBlock<T>) {
        if let data = data {
            DispatchQueue.global().async {
                do {
                    let object = try JSONDecoder().decode(type, from: data)
                    DispatchQueue.main.async {
                        completion(.success(object))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.dataParsing))
                    }
                }
            }
        } else {
            return completion(.failure(NetworkError.dataNotAvailable))
        }
    }
}

enum NetworkError: Int, Error {
    case unknown
    case dataParsing
    case dataNotAvailable
}
