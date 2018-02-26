//
//  CurrencyRateManager.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class NBUCurrencyRatesManager: NSObject, DateDependedPresenterProtocol, FavoritePresenter,DayDateDependedProtocol {
   
    
    
    var cellTypes: [BaseTableCellProtocol.Type] = [NBURatesTableViewCell.self]
    
    weak var delegate: PresenterViewDelegate?
    
    private(set) var commonRates: [CurrencyRate] = []
    private(set) var favorites: [CurrencyRate] = []
    private(set) var rates: [CurrencyRate] = []
    private(set) var favoriteCodes:Set<String> = Set(UserDefaults.standard.stringArray(forKey: "favorite-rates") ?? [])
    private let service = NBURatesService()
    var isProfessional: Bool = false

    var date: Date {
        didSet {
            if NSCalendar.current.compare(date, to: oldValue, toGranularity: .day) != .orderedSame
            {
                delegate?.presenterCancelSearch(self)
                loadList(date: date)
            }
        }
        
    }
    
    private func loadList(date: Date, completion: (([CurrencyRate])->())? = nil)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        service.loadList(param: dateString) { (rates, error) in
            if let error = error
            {
                self.delegate?.presenter(self, getError: error)
            }
            else
            {
                if completion == nil
                {
                    self.rates = rates
                    self.loadList(date: date.addingTimeInterval(-1*24*60*60), completion: { (oldrates) in
                        oldrates.forEach({ (oldrate) in
                            if let index = self.rates.index(where: { (newrate) in oldrate.r030 == newrate.r030 })
                            {
                                self.rates[index].oldRate = oldrate.newRate
                                self.rates[index].yesterdayDate = oldrate.exchangedate
                            }
                        })
                    })
                }
                completion?(rates)
                self.set(rates: self.rates, searchTerm: "")
            }
        }
    }
    
    
    init(date: Date) {
        self.date = date
        super.init()
        registerSettingsBundle()
        updateDisplayFromDefaults()
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(NBUCurrencyRatesManager.defaultsChanged),
                                                         name: UserDefaults.didChangeNotification,
                                                         object: nil)
        
    }
    
    func isFavorite(atSection section: Int, andIndex row: Int) -> Bool
    {
        if favorites.count == 0
        {
            return false
        }
        else
        {
            return section == 0
        }
    }
    
    func toggleMark(section: Int, index: Int)
    {
        if isFavorite(atSection: section, andIndex: index)
        {
            let removed = favorites[index]
            if let index = favorites.index(where: { $0.r030 == removed.r030})
            {
                favorites.remove(at: index)
                commonRates.insert(removed, at: 0)
                favoriteCodes.remove(removed.r030)
                UserDefaults.standard.set(Array(favoriteCodes), forKey: "favorite-rates")
                UserDefaults.standard.synchronize()
            }
        }
        else
        {
            let inserted = commonRates[index]
            if let index = commonRates.index(where: { $0.r030 == inserted.r030})
            {
                favorites.append(inserted)
                commonRates.remove(at: index)
                favoriteCodes.insert(inserted.r030)
                UserDefaults.standard.set(Array(favoriteCodes), forKey: "favorite-rates")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func set(rates: [CurrencyRate], searchTerm: String)
    {
        self.favorites = rates.filter({ self.favoriteCodes.contains($0.r030) && $0.contains(searchTerm) })
        self.commonRates     = rates.filter({ !self.favoriteCodes.contains($0.r030) && $0.contains(searchTerm) })
        delegate?.presenter(self, updateAsProfessional: isProfessional)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        
        //NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func updateDisplayFromDefaults(){
        //Get the defaults
        let defaults = UserDefaults.standard
        //Set the controls to the default values.
        isProfessional = defaults.bool(forKey: "isProfessional")
        delegate?.presenter(self, updateAsProfessional: isProfessional)
        
    }
    
    @objc func defaultsChanged(){
        updateDisplayFromDefaults()
    }

    func updateView() {
        delegate?.presenter(self, updateAsProfessional: isProfessional)
    }
    
    func viewLoaded() {
        loadList(date: date)
    }
    
}

extension NBUCurrencyRatesManager: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return favorites.count > 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.count > 0
        {
            if section == 0
            {
                return favorites.count
            }
            else
            {
                return commonRates.count
            }
        }
        else
        {
            return commonRates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NBURatesTableViewCell") as? NBURatesTableViewCell
        if isFavorite(atSection: indexPath.section, andIndex: indexPath.row)
        {
            cell?.configure(currencyRate: favorites[indexPath.row], isProfessional: isProfessional)
        }
        else
        {
            cell?.configure(currencyRate: commonRates[indexPath.row], isProfessional: isProfessional)
        }
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if favorites.count == 0
        {
            return "Курси Валют"
        }
        else
        {
            if section == 0
            {
                return "Обрані"
            }
            else
            {
                return "Курси Валют"
            }
        }
    }
    
    func currencyCode(inSection section: Int, andIndex index: Int) -> String
    {
        if isFavorite(atSection: section , andIndex: index)
        {
            return favorites[index].cc
        }
        else
        {
            return commonRates[index].cc
        }
    }
    
}

extension NBUCurrencyRatesManager: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        self.set(rates: rates, searchTerm: searchController.searchBar.text ?? "")
    }
}

extension NBUCurrencyRatesManager: UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.presenterCancelSearch(self)
    }
}
