//
//  EndpointTests.swift
//  SmartHomeTests
//
//  Created by Yiming Dong on 2019/8/11.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import XCTest
import Alamofire
@testable import SmartHome

class EndpointTests: XCTestCase {

    func test_turn_on_light1_in_bedroom_should_has_correct_url() {
        let url = Endpoint.fixture(name: "Light1", roomName: "Bedroom", on: true).url
        
        XCTAssertEqual(url, "http://private-1e863-house4591.apiary-mock.com/bedroom/light1/on", "url should be correct")
    }

    func test_turn_off_tv_in_living_room_should_has_correct_url() {
        let url = Endpoint.fixture(name: "TV", roomName: "Living Room", on: false).url
        
        XCTAssertEqual(url, "http://private-1e863-house4591.apiary-mock.com/living-room/tv/off", "url should be correct")
    }
}
