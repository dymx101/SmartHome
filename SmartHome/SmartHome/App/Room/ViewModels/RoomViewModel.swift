//
//  RoomViewModel.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxCocoa
import Alamofire

class RoomViewModel {
    private var room: Room
    private var roomType: RoomType
    
    private var apiService: ApiServiceProvider
    private var dataStorage: DataStoring
    public var fixtures = BehaviorRelay<[FixtureCellViewModel]>(value: [])
    
    init(room: Room, roomType: RoomType, apiService: ApiServiceProvider, dataStorage: DataStoring) {
        self.room = room
        self.roomType = roomType
        self.apiService = apiService
        self.dataStorage = dataStorage
        
        var cellVieModels = [FixtureCellViewModel]()
        room.fixtureStatusMap?.forEach({ (name, on) in
            if let fixtureType = FixtureType.fixtureType(forRoomType: roomType, fixtureName: name) {
                cellVieModels.append(FixtureCellViewModel(name: name, type: fixtureType, on: on))
            }
        })
        
        fixtures.accept(cellVieModels)
    }
    
    @discardableResult
    func turnFixture(on: Bool, fixtureType: FixtureType, completion: @escaping ResultBlock<Bool>) -> DataRequest? {
        return apiService.turnFixture(on: on, fixtureType: fixtureType, completion: completion)
    }
}
