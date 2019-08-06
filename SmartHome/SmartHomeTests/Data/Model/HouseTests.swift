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
        let data = sampleJson.data(using: .utf8)!
        do {
            let house = try JSONDecoder().decode(House.self, from: data)
            
            XCTAssertEqual(house.rooms.bedroom.fixtures[0], "Light1", "data should be correct")
            XCTAssertEqual(house.rooms.bedroom.fixtures[1], "Light2", "data should be correct")
            XCTAssertEqual(house.rooms.bedroom.fixtures[2], "AC", "data should be correct")
            
            XCTAssertEqual(house.rooms.livingRoom.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms.livingRoom.fixtures[1], "TV", "data should be correct")
            
            XCTAssertEqual(house.rooms.kicken.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms.kicken.fixtures[1], "Music", "data should be correct")
            XCTAssertEqual(house.rooms.kicken.fixtures[2], "Slowcooker", "data should be correct")
        } catch {
            print(error)
            XCTFail("decoding should has no error")
        }
    }
    
    let sampleJson = """
{
    "rooms": {
        "Bedroom" : {
            "fixtures": [
                "Light1",
                "Light2",
                "AC"
            ]
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
