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
    func turnFixture(on: Bool, fixtureType: FixtureType, completion: @escaping ResultBlock<Bool>) -> DataRequest?
    
    @discardableResult
    func getWeather(completion: @escaping ResultBlock<Weather>) -> DataRequest?
    
    @discardableResult
    func getFakeWeather(cold: Bool, completion: @escaping ResultBlock<Weather>) -> DataRequest?
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
    func turnFixture(on: Bool, fixtureType: FixtureType, completion: @escaping ResultBlock<Bool>) -> DataRequest? {
        let ep = on ? fixtureType.endpoints.on : fixtureType.endpoints.off
        return networkManager.request(String.self, endpoint: ep) { (result) in
            completion(result.map {$0 == "true"})
        }
    }
    
    @discardableResult
    func getWeather(completion: @escaping ResultBlock<Weather>) -> DataRequest? {
        return networkManager.request(Weather.self, endpoint: .weatherHongKong, completion: completion)
    }
    
    @discardableResult
    func getFakeWeather(cold: Bool, completion: @escaping ResultBlock<Weather>) -> DataRequest? {
        
        // since the response is invalid json, i just return fake weather by myself
        let temp = cold ? 20.0 : 30.0
        completion(.success(Weather.createFromFakeWeather(FakeWeather(weathers: [temp]))))
        return nil
        /*
         let ep = cold ? Endpoint.weatherCold : Endpoint.weatherWarm
         return networkManager.request(FakeWeather.self, endpoint: ep, completion: { (result) in
            completion(result.map {Weather.createFromFakeWeather($0)})
        })*/
    }
}
