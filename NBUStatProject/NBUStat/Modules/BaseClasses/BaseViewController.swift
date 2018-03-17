//
//  BaseViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/16/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? HryvniaTodayTableViewController
        {
            configure(htController: viewController)
        }
        else  if let viewController = segue.destination as? PrivateInternalTableViewController
        {
            configure(privateController: viewController)
        }
        else if let viewController = segue.destination as? DataProviderInfoViewController
        {
            viewController.info = dataProviderInfo()
        }
        
    }

    func configure(htController: HryvniaTodayTableViewController)
    {
        
    }
    
    func configure(privateController: PrivateInternalTableViewController)
    {
        
    }
    
    func dataProviderInfo() -> DataProviderInfoProtocol!
    {
        return nil
    }
}
