//
//  ContainerViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class TableContainerViewController: BaseViewController {

    var presenter: TablePresenterProtocol!

    override func configure(htController: HryvniaTodayTableViewController)
    {
        htController.presenter = presenter
        htController.presenter.delegate = htController
    }
    
    override func dataProviderInfo() -> DataProviderInfoProtocol! {
        return presenter.dataProviderInfo
    }
    
    
    
}
