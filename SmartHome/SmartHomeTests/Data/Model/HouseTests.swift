//
//  HouseTests.swift
//  SmartHomeTests
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import XCTest
@testable import SmartHome
class HouseTests: XCTestCase {

    var house: House!
    
    func test_decodeFromJson_should_succeed() {
        let data = HouseTests.sampleJson.data(using: .utf8)!
        do {
            let house = try JSONDecoder().decode(House.self, from: data)
            
            XCTAssertEqual(house.rooms.bedroom.fixtures[0], "Light1", "data should be correct")
            XCTAssertEqual(house.rooms.bedroom.fixtures[1], "Light2", "data should be correct")
            XCTAssertEqual(house.rooms.bedroom.fixtures[2], "AC", "data should be correct")
            
            XCTAssertEqual(house.rooms.livingRoom.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms.livingRoom.fixtures[1], "TV", "data should be correct")
            
            XCTAssertEqual(house.rooms.kitcken.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms.kitcken.fixtures[1], "Music", "data should be correct")
            XCTAssertEqual(house.rooms.kitcken.fixtures[2], "Slowcooker", "data should be correct")
            
            XCTAssertNotNil(house.rooms.bedroom.fixtureStatusMap, "data should not be nil")
            XCTAssertNil(house.rooms.livingRoom.fixtureStatusMap, "data should be nil")
            XCTAssertNil(house.rooms.kitcken.fixtureStatusMap, "data should be nil")
            
            XCTAssertEqual(house.rooms.bedroom.fixtureStatusMap!["Light1"], true, "data should be correct")
            XCTAssertEqual(house.rooms.bedroom.fixtureStatusMap!["Light2"], false, "data should be correct")
            XCTAssertEqual(house.rooms.bedroom.fixtureStatusMap!["AC"], true, "data should be correct")
        } catch {
            print(error)
            XCTFail("decoding should has no error")
        }
    }
    
    func test_encodeToJson_should_succeed() {
        let data = HouseTests.sampleJson.data(using: .utf8)!
        do {
            let house = try JSONDecoder().decode(House.self, from: data)
            
            let encodedData = try JSONEncoder().encode(house)
            print(String(data: encodedData, encoding: .utf8)!)
            
            let sameHouse = try JSONDecoder().decode(House.self, from: encodedData)
            
            XCTAssertEqual(sameHouse.rooms.bedroom.fixtures[0], "Light1", "data should be correct")
            XCTAssertEqual(sameHouse.rooms.bedroom.fixtures[1], "Light2", "data should be correct")
            XCTAssertEqual(sameHouse.rooms.bedroom.fixtures[2], "AC", "data should be correct")
            
            XCTAssertEqual(sameHouse.rooms.livingRoom.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(sameHouse.rooms.livingRoom.fixtures[1], "TV", "data should be correct")
            
            XCTAssertEqual(sameHouse.rooms.kitcken.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(sameHouse.rooms.kitcken.fixtures[1], "Music", "data should be correct")
            XCTAssertEqual(sameHouse.rooms.kitcken.fixtures[2], "Slowcooker", "data should be correct")
            
            XCTAssertNotNil(sameHouse.rooms.bedroom.fixtureStatusMap, "data should not be nil")
            XCTAssertNil(sameHouse.rooms.livingRoom.fixtureStatusMap, "data should be nil")
            XCTAssertNil(sameHouse.rooms.kitcken.fixtureStatusMap, "data should be nil")
            
            XCTAssertEqual(sameHouse.rooms.bedroom.fixtureStatusMap!["Light1"], true, "data should be correct")
            XCTAssertEqual(sameHouse.rooms.bedroom.fixtureStatusMap!["Light2"], false, "data should be correct")
            XCTAssertEqual(sameHouse.rooms.bedroom.fixtureStatusMap!["AC"], true, "data should be correct")
        } catch {
            print(error)
            XCTFail("decoding should has no error")
        }
    }
    
    static let sampleJson = """
{
    "rooms": {
        "Bedroom" : {
            "fixtures": [
                "Light1",
                "Light2",
                "AC"
            ],
            "fixtureStatusMap": {
                "Light1": true,
                "Light2": false,
                "AC": true
            }
        },
        "Living Room" : {
            "fixtures": [
                "Light",
                "TV"
            ]
        },
        "Kitchen" : {
            "fixtures": [
                "Light",
                "Music",
                "Slowcooker"
            ]
        }
    }
}
"""
}
