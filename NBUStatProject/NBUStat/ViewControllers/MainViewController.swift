//
//  MainViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class MainViewController: UISplitViewController {

    let list = ModuleProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        viewControllers.forEach { ($0 as? ProvidersListTableViewController)?.list = list
            (($0 as? UINavigationController)?.topViewController as? ProvidersListTableViewController)?.list = list
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
