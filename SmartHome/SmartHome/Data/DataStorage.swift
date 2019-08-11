//
//  DataStorage.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

protocol DataStoring {
    func saveHouse(_ house: House?)
    func loadHouse() -> House?
    func saveRoom(_ room: Room, name: String)
}

class DataStorage: DataStoring {
    private let STORE_KEY_HOUSE = "STORE_KEY_HOUSE"
    private var houseCache: House?
    
    func saveHouse(_ house: House?) {
        guard var house = house else {
            UserDefaults.standard.set(nil, forKey: STORE_KEY_HOUSE)
            return
        }
        
        if let houseCache = houseCache {
            houseCache.rooms.forEach { (roomName, room) in
                house.rooms[roomName] = room
            }
        }
        houseCache = house
        
        let data = house.jsonRepresentation()
        UserDefaults.standard.set(data, forKey: STORE_KEY_HOUSE)
    }
    
    func loadHouse() -> House? {
        if houseCache != nil {
            return houseCache
        }
        
        guard let data = UserDefaults.standard.value(forKey: STORE_KEY_HOUSE) as? [String: Any?]
            , let rooms = data["rooms"] as? [String: Any?], !rooms.isEmpty else {
            return nil
        }
        
        houseCache = House(json: data)
        return houseCache
    }
    
    func saveRoom(_ room: Room, name: String) {
        houseCache?.setRoom(room, name: name)
        saveHouse(houseCache)
    }
}
