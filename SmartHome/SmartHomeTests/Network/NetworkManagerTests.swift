//
//  NetworkManagerTests.swift
//  SmartHomeTests
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import XCTest
@testable import SmartHome

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var sessionManager: MockSessionManager!
    override func setUp() {
        sessionManager = MockSessionManager(configuration: URLSessionConfiguration.default)
        networkManager = NetworkManager(sessionManager: sessionManager)
    }

    func test_requestRooms_shoud_succeed() {
        let exp = expectation(description: "request complete")
        networkManager.request(House.self, endpoint: Endpoint.rooms) { (result) in
            exp.fulfill()
            do {
                let data = try result.get()
                XCTAssertNil(data.rooms.bedroom.fixtureStatusMap!["Light1"], "data should be nil")
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }

}
