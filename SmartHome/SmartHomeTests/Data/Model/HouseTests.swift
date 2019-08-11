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
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any?]
            let house = House(json: json)
            
            XCTAssertFalse(house.rooms.isEmpty, "room should not be empty")
            
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtures[0], "Light1", "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtures[1], "Light2", "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtures[2], "AC", "data should be correct")
            
            XCTAssertEqual(house.rooms["Living Room"]!.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms["Living Room"]!.fixtures[1], "TV", "data should be correct")
            
            XCTAssertEqual(house.rooms["Kitchen"]!.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms["Kitchen"]!.fixtures[1], "Music", "data should be correct")
            XCTAssertEqual(house.rooms["Kitchen"]!.fixtures[2], "Slowcooker", "data should be correct")
            
            XCTAssertNotNil(house.rooms["Bedroom"]!.fixtureStatusMap, "data should not be nil")
            XCTAssertNil(house.rooms["Living Room"]!.fixtureStatusMap, "data should be nil")
            XCTAssertNil(house.rooms["Kitchen"]!.fixtureStatusMap, "data should be nil")
            
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtureStatusMap!["Light1"], true, "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtureStatusMap!["Light2"], false, "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtureStatusMap!["AC"], true, "data should be correct")
        } catch {
            print(error)
            XCTFail("decoding should has no error")
        }
    }
    
    func test_encodeToJson_should_succeed() {
        let data = HouseTests.sampleJson.data(using: .utf8)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any?]
            let house = House(json: json!)
            
            let encodedJson = house.jsonRepresentation()
            
            let sameHouse = House(json: encodedJson)
            
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtures[0], "Light1", "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtures[1], "Light2", "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtures[2], "AC", "data should be correct")
            
            XCTAssertEqual(house.rooms["Living Room"]!.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms["Living Room"]!.fixtures[1], "TV", "data should be correct")
            
            XCTAssertEqual(house.rooms["Kitchen"]!.fixtures[0], "Light", "data should be correct")
            XCTAssertEqual(house.rooms["Kitchen"]!.fixtures[1], "Music", "data should be correct")
            XCTAssertEqual(house.rooms["Kitchen"]!.fixtures[2], "Slowcooker", "data should be correct")
            
            XCTAssertNotNil(house.rooms["Bedroom"]!.fixtureStatusMap, "data should not be nil")
            XCTAssertNil(house.rooms["Living Room"]!.fixtureStatusMap, "data should be nil")
            XCTAssertNil(house.rooms["Kitchen"]!.fixtureStatusMap, "data should be nil")
            
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtureStatusMap!["Light1"], true, "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtureStatusMap!["Light2"], false, "data should be correct")
            XCTAssertEqual(house.rooms["Bedroom"]!.fixtureStatusMap!["AC"], true, "data should be correct")
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
