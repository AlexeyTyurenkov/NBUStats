//
//  CurrencyRateTableViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class NBURatesTableViewController: BaseTableViewController, PresenterViewDelegate {
    
    var presenter: NBUCurrencyRatesManager!
    var openDetail: ((String)->())?
    private var isProfessional: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.dataSource = presenter
        super.configureSearch(searchUpdater: presenter)
        register(cellType: NBURatesTableViewCell.self)
        presenter.viewLoaded()
    }
    
    
    

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.viewLoaded()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let isFavorite = presenter.isFavorite(atSection: indexPath.section, andIndex: indexPath.row)
        let more = UITableViewRowAction(style: .normal, title: isFavorite ? "З обраних" : "В обрані") {
            action, index in
            self.presenter.toggleMark(section: index.section, index: index.row)
            self.tableView.reloadData()
        }
        more.backgroundColor = isFavorite ? UIColor(red: 213.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0) : UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0)
        return [more]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cc = self.presenter.currencyCode(inSection: indexPath.section, andIndex: indexPath.row)
        openDetail?(cc)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView  else { return }
        header.textLabel?.textColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
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
