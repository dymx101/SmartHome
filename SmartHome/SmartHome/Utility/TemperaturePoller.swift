//
//  TemperaturePoller.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation
import RxCocoa

class TemperaturePoller {
    private var apiService: ApiServiceProvider
    
    init(apiService: ApiServiceProvider) {
        self.apiService = apiService
    }
    
    var cool = BehaviorRelay<Bool>(value: false)
    private var shouldStop = false
    func start() {
        shouldStop = false
        poll()
    }
    
    func stop() {
        shouldStop = true
    }
    
    private func poll() {
//        apiService.getRooms(completion: <#T##ResultBlock<House>##ResultBlock<House>##(Result<House, Error>) -> Void#>)
    }
}
