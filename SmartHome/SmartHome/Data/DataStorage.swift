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
            house.rooms.bedroom.fixtureStatusMap = houseCache.rooms.bedroom.fixtureStatusMap
            house.rooms.livingRoom.fixtureStatusMap = houseCache.rooms.livingRoom.fixtureStatusMap
            house.rooms.kitcken.fixtureStatusMap = houseCache.rooms.kitcken.fixtureStatusMap
        }
        houseCache = house
        
        let data = try? JSONEncoder().encode(house)
        UserDefaults.standard.set(data, forKey: STORE_KEY_HOUSE)
    }
    
    func loadHouse() -> House? {
        if houseCache != nil {
            return houseCache
        }
        
        guard let data = UserDefaults.standard.value(forKey: STORE_KEY_HOUSE) as? Data else {
            return nil
        }
        
        houseCache = try? JSONDecoder().decode(House.self, from: data)
        return houseCache
    }
}
