//
//  DataStorageTests.swift
//  SmartHomeTests
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import XCTest
@testable import SmartHome

class DataStorageTests: XCTestCase {
    
    var object: DataStorage!

    override func setUp() {
        object = DataStorage()
    }

    func test_saveAndLoadHouse_should_work() {
        let data = HouseTests.sampleJson.data(using: .utf8)!
        let house = try! JSONDecoder().decode(House.self, from: data)
        object.saveHouse(house)
        
        let sameHouse = object.loadHouse()
        XCTAssertNotNil(sameHouse, "data should not be nil")
        XCTAssertEqual(sameHouse!.rooms.bedroom.fixtureStatusMap!["Light1"], true, "data should be correct")
    }
}
