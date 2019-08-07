//
//  ApiService.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiServiceProvider {
    @discardableResult
    func getRooms(completion: @escaping ResultBlock<House>) -> DataRequest?
    
    @discardableResult
    func turnBedroomLight1(on: Bool, completion: @escaping ResultBlock<Bool>) -> DataRequest?
}

class ApiService: ApiServiceProvider {
    private var networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    @discardableResult
    func getRooms(completion: @escaping ResultBlock<House>) -> DataRequest? {
        return networkManager.request(House.self, endpoint: .rooms, completion: completion)
    }
    
    @discardableResult
    func turnBedroomLight1(on: Bool, completion: @escaping ResultBlock<Bool>) -> DataRequest? {
        let ep = on ? Endpoint.bedroomLight1On : Endpoint.bedroomLight1Off
        return networkManager.request(String.self, endpoint: ep) { (result) in
            completion(result.map {$0 == "true"})
        }
    }
}
