//
//  Endpoint.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint: String, URLRequestConvertible {
    case rooms = "/rooms"
    case bedroomLight1On = "/bedroom/light1/on"
    case bedroomLight1Off = "/bedroom/light1/off"
    case bedroomLight2On = "/bedroom/light2/on"
    case bedroomLight2Off = "/bedroom/light2/off"
    case bedroomAcOn = "/bedroom/ac/on"
    case bedroomAcOff = "/bedroom/ac/off"
    case livingRoomLightOn = "/living-room/light/on"
    case livingRoomLightOff = "/living-room/light/off"
    case livingRoomTvOn = "/living-room/tv/on"
    case livingRoomTvOff = "/living-room/tv/off"
    case kitchenLightOn = "/kitchen/light/on"
    case kitchenLightOff = "/kitchen/light/off"
    case kitchenMusicOn = "/kitchen/music/on"
    case kitchenMusicOff = "/kitchen/music/off"
    case kitchenSlowcookerOn = "/kitchen/slowcooker/on"
    case kitchenSlowcookerOff = "/kitchen/slowcooker/off"
    case weatherCold = "/weather/cold"
    case weatherWarm = "/weather/warm"
    case weatherHongKong = "https://www.metaweather.com/api/location/2165352/"
    
    private var roomApiBaseUrl: String {return "http://private-1e863-house4591.apiary-mock.com"}
    
    private var url: String {
        if self == .weatherHongKong {
            return rawValue
        }
        
        return roomApiBaseUrl + rawValue
    }
    
    func asURLRequest() throws -> URLRequest {
        return try URLRequest(url: self.url, method: .get, headers: nil)
    }
}
