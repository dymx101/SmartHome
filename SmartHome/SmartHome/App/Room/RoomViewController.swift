//
//  RoomViewController.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RoomViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RoomViewModel?
    
    private let disposeBag = DisposeBag()
    
    static func createFromStoryboard() -> RoomViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoomViewController") as! RoomViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.fixtures.bind(to: tableView.rx.items(cellIdentifier: "fixtureCell", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.name
        }.disposed(by: disposeBag)
    }
}
