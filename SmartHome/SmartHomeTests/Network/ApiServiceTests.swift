//
//  ApiServiceTests.swift
//  SmartHomeTests
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import XCTest
import Alamofire
@testable import SmartHome

class ApiServiceTests: XCTestCase {

    var networkManager: NetworkManager!
    var sessionManager: SessionManager!
    var service: ApiService!
    
    override func setUp() {
        sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
        networkManager = NetworkManager(sessionManager: sessionManager)
        service = ApiService(networkManager: networkManager)
    }

    func test_requestRooms_shoud_succeed() {
        let exp = expectation(description: "request complete")
        service.getRooms { (result) in
            exp.fulfill()
            do {
                let _ = try result.get()
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }
    
    func test_turnBedroomLight1_on_shoud_succeed() {
        let exp = expectation(description: "request complete")
        service.turnFixture(on: true, fixtureType: FixtureType.bedroomLight1) { (result) in
            exp.fulfill()
            do {
                let success = try result.get()
                XCTAssertTrue(success, "operation should succeed")
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }
    
    func test_turnBedroomLight1_off_shoud_succeed() {
        let exp = expectation(description: "request complete")
        service.turnFixture(on: false, fixtureType: FixtureType.bedroomLight1) { (result) in
            exp.fulfill()
            do {
                let success = try result.get()
                XCTAssertTrue(success, "operation should succeed")
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }
    
    func test_getWeather_shoud_succeed() {
        let exp = expectation(description: "request complete")
        service.getWeather { result in
            exp.fulfill()
            do {
                let _ = try result.get()
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }
    
    func test_getFakeWeather_cold_shoud_succeed() {
        let exp = expectation(description: "request complete")
        service.getFakeWeather(cold: true) { result in
            exp.fulfill()
            do {
                let weather = try result.get()
                XCTAssertTrue(weather.weathers.first!.temp == 20, "temp should be correct")
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }
    
    func test_getFakeWeather_warm_shoud_succeed() {
        let exp = expectation(description: "request complete")
        service.getFakeWeather(cold: false) { result in
            exp.fulfill()
            do {
                let weather = try result.get()
                XCTAssertTrue(weather.weathers.first!.temp == 30, "temp should be correct")
            } catch {
                XCTFail("request should not get error: \(error)")
            }
        }
        
        wait(for: [exp], timeout: UnitTestConstants.timeout)
    }
}
