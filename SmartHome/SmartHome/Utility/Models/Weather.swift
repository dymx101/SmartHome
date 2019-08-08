//
//  Weather.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/8.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var weathers: [WeatherItem]
    
    private enum CodingKeys: String, CodingKey {
        case weathers = "consolidated_weather"
    }
    
    static func createFromFakeWeather(_ fakeWeather: FakeWeather) -> Weather {
        return Weather(weathers: [WeatherItem(temp: fakeWeather.weathers.first ?? 0.0)])
    }
}

struct WeatherItem: Decodable {
    var temp: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp = "the_temp"
    }
}
