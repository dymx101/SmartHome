//
//  RoomViewModel.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift
import RxCocoa
import Alamofire

class RoomViewModel {
    private var room: Room
    private var roomName: String
    
    private var apiService: ApiServiceProvider
    private var dataStorage: DataStoring
    public var fixtures = BehaviorRelay<[FixtureCellViewModel]>(value: [])
    
    private var tempPoller: TemperaturePoller
    private let disposeBag = DisposeBag()
    
    private let fixtureNameAC = "AC"
    
    init(room: Room, roomName: String, apiService: ApiServiceProvider, dataStorage: DataStoring) {
        self.room = room
        self.roomName = roomName
        self.apiService = apiService
        self.dataStorage = dataStorage
        self.tempPoller = TemperaturePoller(apiService: apiService)
        
        generateCellViewModels()
        
        observePollingTemperature()
    }
    
    private var hasAirCon: Bool {
        return room.fixtures.contains(fixtureNameAC)
    }
    
    private func observePollingTemperature() {
        guard hasAirCon else {
            return
        }
        
        tempPoller.isCold.subscribe(onNext: { [weak self] isCold in
            let acIsOn = self?.room.fixtureStatusMap?["AC"] ?? false
            if isCold && acIsOn  {
                SVProgressHUD.showInfo(withStatus: "It's too cold, turn AC off")
                self?.updateFixtureStatus(on: false, name: "AC")
            } else if !isCold && !acIsOn {
                SVProgressHUD.showInfo(withStatus: "It's too hot, turn AC on")
                self?.updateFixtureStatus(on: true, name: "AC")
            }
        }).disposed(by: disposeBag)
    }
    
    private func generateCellViewModels() {
        var cellVieModels = [FixtureCellViewModel]()
        room.fixtureStatusMap?.keys.sorted().forEach({ (name) in
            let on = room.fixtureStatusMap?[name] ?? false
            cellVieModels.append(FixtureCellViewModel(name: name, roomName: roomName, on: on))
        })
        
        fixtures.accept(cellVieModels)
    }
    
    func updateFixtureStatus(on: Bool, name: String) {
        room.fixtureStatusMap?[name] = on
        // regerate the cell view models
        generateCellViewModels()
        // save the change to storage
        dataStorage.saveRoom(room, name: roomName)
    }
    
    @discardableResult
    func turnFixture(on: Bool, fixtureName: String, roomName: String, completion: @escaping ResultBlock<Bool>) -> DataRequest? {
        return apiService.turnFixture(on: on, fixtureName: fixtureName, roomName: roomName, completion: completion)
    }
    
    func startTemperaturePolling() {
        if hasAirCon {
            tempPoller.start()
        }
    }
    
    func stopTemperaturePolling() {
        tempPoller.stop()
    }
}
