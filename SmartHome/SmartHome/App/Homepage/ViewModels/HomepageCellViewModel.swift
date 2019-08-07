//
//  HomepageCellViewModel.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/7.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import Foundation

struct HomepageCellViewModel {
    var name: String {
        return type.rawValue
    }
    let room: Room
    let type: RoomType
}
