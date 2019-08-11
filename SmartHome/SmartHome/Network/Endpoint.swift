//
//  Endpoint.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestConvertible {
    case rooms
    case fixture(name: String, roomName: String, on: Bool)
    case weatherCold
    case weatherWarm
    case weatherHongKong
    
    private var roomApiBaseUrl: String {return "http://private-1e863-house4591.apiary-mock.com"}
    
    var url: String {
        switch self {
        case .weatherHongKong:
            return "https://www.metaweather.com/api/location/2165352/"
        case .weatherCold:
            return roomApiBaseUrl + "/weather/cold"
        case .weatherWarm:
            return roomApiBaseUrl + "/weather/warm"
        case .rooms:
            return roomApiBaseUrl + "/rooms"
        case let .fixture(name, roomName, on):
            return getFixtureUrl(forName: name, roomName: roomName, on: on)
        }
    }
    
    private func getFixtureUrl(forName fixtureName: String, roomName: String, on: Bool) -> String {
        return "\(roomApiBaseUrl)/\(roomName)/\(fixtureName)/\(on ? "on" : "off")"
            .lowercased()
            .replacingOccurrences(of: " ", with: "-")
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(url: self.url, method: .get, headers: nil)
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        return request
    }
}
