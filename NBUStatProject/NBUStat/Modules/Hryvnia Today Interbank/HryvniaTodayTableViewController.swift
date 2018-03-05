//
//  HryvniaTodayTableViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class HryvniaTodayTableViewController: BaseTableViewController, PresenterViewDelegate {
    
    var presenter: PresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRefreshControl()
        self.tableView.dataSource = presenter as! UITableViewDataSource
        presenter.cellTypes.forEach { self.register(cellType: $0)}
        presenter.viewLoaded()
    }

    @objc override func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.viewLoaded()
    }
    
    func presenterDidLoad(_: PresenterProtocol) {
        
    }
    
    func presenterWillLoad(_: PresenterProtocol) {
        
    }
    
    func presenter(_: PresenterProtocol, getError error: Error) {
        let alert = UIAlertController(title: "Помилка завантаження", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presenterCancelSearch(_: PresenterProtocol) {
        DispatchQueue.main.async {
            self.searchViewController?.isActive = false
            self.searchViewController?.searchBar.text = ""
            self.searchViewController?.searchBar.resignFirstResponder()
            self.searchViewController?.dismiss(animated: true, completion: {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                
            })
            
        }
    }
    
    func presenter(_: PresenterProtocol, updateAsProfessional: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

}
