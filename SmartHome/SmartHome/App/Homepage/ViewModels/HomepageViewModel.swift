//
//  HomepageViewModel.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxCocoa

class HomepageViewModel {
    private var apiService: ApiServiceProvider
    private var dataStorage: DataStoring
    public var rooms = BehaviorRelay<[HomepageCellViewModel]>(value: [])
    
    init(apiService: ApiServiceProvider, dataStorage: DataStoring) {
        self.apiService = apiService
        self.dataStorage = dataStorage
    }
    
    func getRooms() {
        // get data from local storage
        if var house = dataStorage.loadHouse() {
            house.rooms.bedroom.populateMap()
            house.rooms.livingRoom.populateMap()
            house.rooms.kitcken.populateMap()
            
            rooms.accept([HomepageCellViewModel(room: house.rooms.bedroom, type: .bedroom),
                                HomepageCellViewModel(room: house.rooms.livingRoom, type: .livingRoom),
                                HomepageCellViewModel(room: house.rooms.kitcken, type: .kitcken)])
            return
        }
        
        // get data from api
        SVProgressHUD.show()
        apiService.getRooms { [weak self] (result) in
            SVProgressHUD.dismiss()
            do {
                var house = try result.get()
                house.rooms.bedroom.populateMap()
                house.rooms.livingRoom.populateMap()
                house.rooms.kitcken.populateMap()
                
                self?.rooms.accept([HomepageCellViewModel(room: house.rooms.bedroom, type: .bedroom),
                                    HomepageCellViewModel(room: house.rooms.livingRoom, type: .livingRoom),
                                    HomepageCellViewModel(room: house.rooms.kitcken, type: .kitcken)])
                // cache the house data
                self?.dataStorage.saveHouse(house)
            } catch {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
