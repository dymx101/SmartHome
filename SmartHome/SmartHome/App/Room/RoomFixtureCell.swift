//
//  HomepageRoomCell.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/8.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import UIKit
import RxSwift

class RoomFixtureCell: UITableViewCell {

    @IBOutlet weak var switchView: UISwitch!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}
