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
import SVProgressHUD

class RoomViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = 60.0
        }
    }
    
    var viewModel: RoomViewModel?
    
    private let disposeBag = DisposeBag()
    
    static func createFromStoryboard() -> RoomViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoomViewController") as! RoomViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.fixtures.bind(to: tableView.rx.items(cellIdentifier: "fixtureCell", cellType: RoomFixtureCell.self)) { row, model, cell in
            cell.textLabel?.text = model.name
            cell.switchView.isOn = model.on
            
            cell.switchView.rx.isOn
            .changed
            .debounce(.microseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                SVProgressHUD.show()
                self?.viewModel?.turnFixture(on: value, fixtureName: model.name, roomName: model.roomName, completion: { [weak self] (result) in
                    SVProgressHUD.dismiss()
                    do {
                        let success = try result.get()
                        if success {
                            self?.viewModel?.updateFixtureStatus(on: value, name: model.name)
                        } else {
                            SVProgressHUD.showInfo(withStatus: "Operation Failed")
                        }
                    } catch {
                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                    }
                })
            }).disposed(by: cell.disposeBag)
            
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.startTemperaturePolling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.stopTemperaturePolling()
    }
}
