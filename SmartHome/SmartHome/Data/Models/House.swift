//
//  House.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct House: Codable {
    let rooms: HouseRooms
}

struct HouseRooms: Codable {
    let bedroom: Room
    let livingRoom: Room
    let kicken: Room
    
    private enum CodingKeys: String, CodingKey {
        case bedroom = "Bedroom"
        case livingRoom = "Living Room"
        case kicken = "Kitchen"
    }
}
