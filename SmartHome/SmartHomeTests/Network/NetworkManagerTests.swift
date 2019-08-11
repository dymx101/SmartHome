//
//  NetworkManagerTests.swift
//  SmartHomeTests
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import XCTest
import Alamofire
@testable import SmartHome

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var sessionManager: SessionManager!
    override func setUp() {
        sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
        networkManager = NetworkManager(sessionManager: sessionManager)
    }

    func test_requestRooms_shoud_succeed() {
        let exp = expectation(description: "request complete")
        networkManager.request(Data.self, endpoint: Endpoint.rooms) { (result) in
            exp.fulfill()
            do {
                let _ = try result.get()
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }

}
