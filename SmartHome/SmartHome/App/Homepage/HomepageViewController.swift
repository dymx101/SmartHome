//
//  HomepageViewController.swift
//  SmartHome
//
//  Created by Yiming Dong on 2019/8/6.
//  Copyright © 2019 Yiming Dong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class HomepageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: HomepageViewModel!
    
    private let sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
    private var networkManager: NetworkManaging!
    private var apiService: ApiService!
    private var dataStorage: DataStorage!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkManager(sessionManager: sessionManager)
        apiService = ApiService(networkManager: networkManager)
        dataStorage = DataStorage()
        viewModel = HomepageViewModel(apiService: apiService, dataStorage: dataStorage)
        
        viewModel.rooms.bind(to: tableView.rx.items(cellIdentifier: "roomCell", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.name
        }.disposed(by: disposeBag)
        
        viewModel.getRooms()
    }
}
