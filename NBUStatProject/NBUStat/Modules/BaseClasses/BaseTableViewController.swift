//
//  BaseTableViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var searchViewController: UISearchController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func configureSearch(searchUpdater: UISearchResultsUpdating & UISearchBarDelegate)
    {
        self.searchViewController = UISearchController(searchResultsController: nil)
        definesPresentationContext = true
        self.searchViewController?.hidesNavigationBarDuringPresentation = false
        
        self.searchViewController?.dimsBackgroundDuringPresentation = false
        self.searchViewController?.searchResultsUpdater = searchUpdater
        self.searchViewController?.searchBar.delegate = searchUpdater
        self.searchViewController?.searchBar.placeholder = NSLocalizedString("Шукати за кодом або назвою", comment: "Search")
        self.searchViewController?.searchBar.sizeToFit()
        self.searchViewController?.searchBar.tintColor = UIColor.white
        tableView.tableHeaderView = searchViewController!.searchBar
    }
    
    func register(cellType: BaseTableCellProtocol.Type)
    {
        tableView.register(cellType.Nib(), forCellReuseIdentifier: cellType.CellIdentifier())
    }
    
}
