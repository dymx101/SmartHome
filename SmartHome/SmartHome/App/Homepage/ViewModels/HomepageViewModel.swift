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
    
    private func generateCellViewModels(_ house: inout House) {
        var roomsProcessed = [String: Room]()
        house.rooms.forEach { (arg) in
            var (name, room) = arg
            room.populateMap()
            roomsProcessed[name] = room
        }
        house.rooms = roomsProcessed
        
        let cellViewModels: [HomepageCellViewModel] = house.rooms.keys.sorted().compactMap { (name) in
            if let room = house.rooms[name] {
                return HomepageCellViewModel(room: room, name: name)
            }
            
            return nil
        }
        
        rooms.accept(cellViewModels)
    }
    
    func getRooms() {
        // get data from local storage
        if var house = dataStorage.loadHouse() {
            generateCellViewModels(&house)
            return
        }
        
        // get data from api
        SVProgressHUD.show()
        apiService.getRooms { [weak self] (result) in
            SVProgressHUD.dismiss()
            do {
                let data = try result.get()
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any?] {
                    var house = House(json: json)
                    self?.generateCellViewModels(&house)
                    // cache the house data
                    self?.dataStorage.saveHouse(house)
                } else {
                    SVProgressHUD.showError(withStatus: NetworkError.dataNotAvailable.localizedDescription)
                }
            } catch {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
