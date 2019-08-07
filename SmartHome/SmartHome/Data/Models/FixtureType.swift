//
//  FixtureType.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

enum FixtureType {
    case bedroomLight1
    case bedroomLight2
    case bedroomAC
    case livingRoomLight
    case livingRoomTV
    case kitchenLight
    case kitchenMusic
    case kitchenSlowcooker
    
    var endpoints: (on: Endpoint, off: Endpoint) {
        switch self {
        case .bedroomLight1:
            return (on: Endpoint.bedroomLight1On, off: Endpoint.bedroomLight1Off)
        case .bedroomLight2:
            return (on: Endpoint.bedroomLight2On, off: Endpoint.bedroomLight2Off)
        case .bedroomAC:
            return (on: Endpoint.bedroomAcOn, off: Endpoint.bedroomAcOff)
        case .livingRoomLight:
            return (on: Endpoint.livingRoomLightOn, off: Endpoint.livingRoomLightOff)
        case .livingRoomTV:
            return (on: Endpoint.livingRoomTvOn, off: Endpoint.livingRoomTvOff)
        case .kitchenLight:
            return (on: Endpoint.kitchenLightOn, off: Endpoint.kitchenLightOff)
        case .kitchenMusic:
            return (on: Endpoint.kitchenMusicOn, off: Endpoint.kitchenMusicOff)
        case .kitchenSlowcooker:
            return (on: Endpoint.kitchenSlowcookerOn, off: Endpoint.kitchenSlowcookerOff)
        }
    }
    
    static private let map: [RoomType: [String: FixtureType]] = [
        .bedroom: ["Light1": .bedroomLight1, "Light2": .bedroomLight2, "AC": .bedroomAC],
        .livingRoom: ["Light": .livingRoomLight, "TV": .livingRoomTV],
        .kitcken: ["Light": .kitchenLight, "Music": .kitchenMusic, "Slowcooker": .kitchenSlowcooker]
    ]
    
    static func fixtureType(forRoomType roomType: RoomType, fixtureName: String) -> FixtureType? {
        return map[roomType]?[fixtureName]
    }
}
