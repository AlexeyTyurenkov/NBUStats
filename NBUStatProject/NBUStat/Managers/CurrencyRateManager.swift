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
    private(set) var rates: [CurrencyRate] = []
    private(set) var favorites: [CurrencyRate] = []
    func loadList(date: Date, completion: @escaping ()->())
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        let defaults = UserDefaults.standard
        let favoriteCodes = defaults.array(forKey: "favorite-rates") as? [String]
        Alamofire.request(String(format:"https://www.bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date=%@&json",dateString),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                                case .success(let result):
                                
                                    if let result = result as? [[String:AnyObject]]
                                    {
                                        let rates = result.map{ CurrencyRate.init(dictionary: $0) }
                                        if let favoritesCodes = favoriteCodes, favoritesCodes.count > 0
                                        {
                                            self.favorites = rates.filter({ favoritesCodes.contains($0.r030)})
                                            self.rates     = rates.filter({ !favoritesCodes.contains($0.r030)})
                                        }
                                        else
                                        {
                                            self.rates = rates
                                        }
                                        completion()
                                    }
                                
                                default: break;
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
                return rates.count
            }
        }
        else
        {
            return rates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyRateTableViewCell") as? CurrencyRateTableViewCell
        cell?.configure(currencyRate: rates[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
