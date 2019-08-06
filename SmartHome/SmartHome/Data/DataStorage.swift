//
//  DataStorage.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

protocol DataStoraging {
    func saveHouse(_ house: House?)
    func loadHouse() -> House?
}

class DataStorage: DataStoraging {
    private let STORE_KEY_HOUSE = "STORE_KEY_HOUSE"
    func saveHouse(_ house: House?) {
        let data = try? JSONEncoder().encode(house)
        UserDefaults.standard.set(data, forKey: STORE_KEY_HOUSE)
    }
    
    func loadHouse() -> House? {
        guard let data = UserDefaults.standard.value(forKey: STORE_KEY_HOUSE) as? Data else {
            return nil
        }
        
        return try? JSONDecoder().decode(House.self, from: data)
    }
}
