//
//  CurrencyRateTableViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

protocol FavoritePresenter
{
    func isFavorite(atSection: Int, andIndex: Int) -> Bool
    func currencyCode(inSection: Int, andIndex: Int) -> String
    func toggleMark(section: Int, index: Int)
}


class NBURatesTableViewController: BaseTableViewController, PresenterViewDelegate {
    
    var presenter: (DateDependedPresenterProtocol & TablePresenterProtocol)!
    var openDetail: ((String)->())?
    private var isProfessional: Bool = false
    
    
    
    private var favoritePresenter: FavoritePresenter? {
        return presenter as? FavoritePresenter
    }
    
    private var tableDataSource: UITableViewDataSource
    {
        return presenter as! UITableViewDataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureRefreshControl()
        self.tableView.dataSource = tableDataSource
        if let uiSearchDelegate = presenter as? UISearchResultsUpdating & UISearchBarDelegate
        {
            super.configureSearch(searchUpdater: uiSearchDelegate)
        }
        presenter.cellTypes.forEach { self.register(cellType: $0)}
        presenter.viewLoaded()
    }
 
    @objc override func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.viewLoaded()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        var more: [UITableViewRowAction] = []
        if let isFavorite = favoritePresenter?.isFavorite(atSection: indexPath.section, andIndex: indexPath.row)
        {
            let action = UITableViewRowAction(style: .normal, title: isFavorite ? "З обраних" : "В обрані") {
            action, index in
            self.favoritePresenter?.toggleMark(section: index.section, index: index.row)
            self.tableView.reloadData()
            }
            action.backgroundColor = isFavorite ? ThemeManager.shared.negativeColor : ThemeManager.shared.positiveColor
            more.append(action)
        }
        return more
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cc = self.favoritePresenter?.currencyCode(inSection: indexPath.section, andIndex: indexPath.row)
        {
            openDetail?(cc)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView  else { return }
        header.textLabel?.textColor = ThemeManager.shared.neutralColor
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
            self.isProfessional = updateAsProfessional
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
}
