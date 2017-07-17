//
//  CurrencyRateManager.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CurrencyRateManager: NSObject {
    private(set) var commonRates: [CurrencyRate] = []
    private(set) var favorites: [CurrencyRate] = []
    private(set) var rates: [CurrencyRate] = []
    private(set) var favoriteCodes:Set<String> = Set(UserDefaults.standard.stringArray(forKey: "favorite-rates") ?? [])
    
    var updateCallBack:()->() = {}
    var cancelSearch: ()->() = {}
    var errorMessage: (Error)->() = { _ in }
    
    func loadList(date: Date, completion: (([CurrencyRate])->())? = nil)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        Alamofire.request(String(format:"https://www.bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date=%@&json",dateString),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                                case .success(let result):
                                
                                    if let result = result as? [[String:AnyObject]]
                                    {
                                        let rates = result.map{ CurrencyRate.init(dictionary: $0) }
                                        if completion == nil
                                        {
                                            self.rates = rates
                                            self.loadList(date: date.addingTimeInterval(-1*24*60*60), completion: { (oldrates) in
                                                oldrates.forEach({ (oldrate) in
                                                    if let index = self.rates.index(where: { (newrate) in oldrate.r030 == newrate.r030 })
                                                    {
                                                        self.rates[index].oldRate = oldrate.newRate
                                                    }
                                                })
                                            })
                                        }
                                        completion?(rates)
                                        self.set(rates: self.rates, searchTerm: "")
                                    }
                                case .failure(let error):
                                    self.errorMessage(error)
                            }
        }
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
        if self.favoriteCodes.count > 0
        {
            self.favorites = rates.filter({ self.favoriteCodes.contains($0.r030) && (searchTerm == "" || $0.cc.contains(searchTerm) || $0.name.contains(searchTerm) || $0.r030.contains(searchTerm)) })
            self.commonRates     = rates.filter({ !self.favoriteCodes.contains($0.r030) && $0.contains(searchTerm) })
        }
        else
        {
            self.favorites   = []
            self.commonRates = rates.filter( { searchTerm == "" || $0.cc.contains(searchTerm) || $0.name.contains(searchTerm) || $0.r030.contains(searchTerm) })
        }
        self.updateCallBack()
    }
    
}

extension CurrencyRateManager: UITableViewDataSource
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyRateTableViewCell") as? CurrencyRateTableViewCell
        if isFavorite(atSection: indexPath.section, andIndex: indexPath.row)
        {
            cell?.configure(currencyRate: favorites[indexPath.row])
        }
        else
        {
            cell?.configure(currencyRate: commonRates[indexPath.row])
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

extension CurrencyRateManager: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        self.set(rates: rates, searchTerm: searchController.searchBar.text ?? "")
    }
}

extension CurrencyRateManager: UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
}
