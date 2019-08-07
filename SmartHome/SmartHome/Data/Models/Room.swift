//
//  Room.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct Room: Codable {
    let fixtures: [String]
    var fixtureStatusMap: [String: Bool]?
    
    mutating func populateMap() {
        if fixtureStatusMap == nil {
            var map =  [String: Bool]()
            fixtures.forEach { (name) in
                map[name] = false
            }
            fixtureStatusMap = map
        }
    }
}
