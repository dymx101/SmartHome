//
//  House.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct House: Codable {
    var rooms: HouseRooms
    
    mutating func setRoom(_ room: Room, type: RoomType) {
        switch type {
        case .bedroom:
            rooms.bedroom = room
        case .livingRoom:
            rooms.livingRoom = room
        case .kitcken:
            rooms.kitcken = room
        }
    }
}

struct HouseRooms: Codable {
    var bedroom: Room
    var livingRoom: Room
    var kitcken: Room
    
    private enum CodingKeys: String, CodingKey {
        case bedroom = "Bedroom"
        case livingRoom = "Living Room"
        case kitcken = "Kitchen"
    }
}
