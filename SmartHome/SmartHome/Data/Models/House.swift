//
//  House.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct House {
    var rooms = [String: Room]()
    
    init(json: [String: Any?]) {
        guard let rooms = json["rooms"] as? [String: Any?] else {return}
        
        rooms.keys.forEach { (roomName) in
            if let roomJson = rooms[roomName] as? [String: Any?],
                let roomData = try? JSONSerialization.data(withJSONObject: roomJson, options: JSONSerialization.WritingOptions.prettyPrinted),
                let room = try? JSONDecoder().decode(Room.self, from: roomData){
                self.rooms[roomName] = room
            }
        }
    }
    
    func jsonRepresentation() -> [String: Any?] {
        var json = [String: Any?]()
        var jsonRooms = [String: Any?]()
        rooms.forEach { (name, room) in
            if let roomData = try? JSONEncoder().encode(room),
                let roomJson = try? JSONSerialization.jsonObject(with: roomData, options: JSONSerialization.ReadingOptions.allowFragments) {
                jsonRooms[name] = roomJson
            }
        }
        
        json["rooms"] = jsonRooms
        
        return json
    }
    
    mutating func setRoom(_ room: Room, name: String) {
        rooms[name] = room
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
