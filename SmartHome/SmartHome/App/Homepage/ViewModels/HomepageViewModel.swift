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
        if let house = dataStorage.loadHouse() {
            rooms.accept([HomepageCellViewModel(name: "Bedroom", room: house.rooms.bedroom),
                                HomepageCellViewModel(name: "Living Room", room: house.rooms.livingRoom),
                                HomepageCellViewModel(name: "Kitchen", room: house.rooms.kitcken)])
            return
        }
        
        // get data from api
        SVProgressHUD.show()
        apiService.getRooms { [weak self] (result) in
            SVProgressHUD.dismiss()
            do {
                let house = try result.get()
                
                self?.rooms.accept([HomepageCellViewModel(name: "Bedroom", room: house.rooms.bedroom),
                                    HomepageCellViewModel(name: "Living Room", room: house.rooms.livingRoom),
                                    HomepageCellViewModel(name: "Kitchen", room: house.rooms.kitcken)])
                // cache the house data
                self?.dataStorage.saveHouse(house)
            } catch {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
