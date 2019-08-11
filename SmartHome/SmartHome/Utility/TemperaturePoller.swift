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
    
    private let inteval = 60.0
    private let conditionTemp = 25.0
    
    var isCold = BehaviorRelay<Bool>(value: false)
    private var shouldStop = false
    
    init(apiService: ApiServiceProvider) {
        self.apiService = apiService
    }
    func start() {
        shouldStop = false
        poll()
    }
    
    func stop() {
        shouldStop = true
    }
    
    private func decideIfIsCold(_ weather: Weather) -> Bool {
        guard let temp = weather.weathers.first?.temp else {
            return false
        }
        
        return temp < conditionTemp
    }
    
    private func poll() {
        
        if shouldStop {
            return
        }
        
//        apiService.getFakeWeather(cold: true) { [weak self] (result) in
        apiService.getWeather { [weak self] (result) in
            do {
                let weather = try result.get()
                self?.isCold.accept(self?.decideIfIsCold(weather) ?? false)
                print("got weather data, temp = \(weather.weathers.first?.temp ?? 0.0)")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + inteval) {
            self.poll()
        }
    }
}
