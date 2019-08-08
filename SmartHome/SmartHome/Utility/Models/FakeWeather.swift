//
//  FakeWeather.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/8.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct FakeWeather: Decodable {
    var weathers: [Double]
    
    private enum CodingKeys: String, CodingKey {
        case weathers = "consolidated_weather"
    }
}
