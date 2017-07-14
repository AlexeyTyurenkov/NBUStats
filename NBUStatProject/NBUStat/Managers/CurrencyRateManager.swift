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
    
    func loadList(date: Date, completion: @escaping ()->())
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
                                        self.rates = result.map{ CurrencyRate.init(dictionary: $0) }
                                        completion()
                                    }
                                
                                default: break;
                            }
        }
    }
    
    
}

extension CurrencyRateManager: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyRateTableViewCell") as? CurrencyRateTableViewCell
        cell?.configure(currencyRate: rates[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
