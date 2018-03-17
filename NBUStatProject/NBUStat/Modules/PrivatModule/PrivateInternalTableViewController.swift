//
//  PrivateInternalTableViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/17/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class PrivateInternalTableViewController: BaseTableViewController {

    var presenter: TablePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    func configure(with presenter: TablePresenterProtocol)
    {
        self.tableView.dataSource = presenter as? UITableViewDataSource
        presenter.cellTypes.forEach { self.register(cellType: $0)}
    }
}
