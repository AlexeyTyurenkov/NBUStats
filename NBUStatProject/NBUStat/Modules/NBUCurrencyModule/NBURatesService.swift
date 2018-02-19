//
//  NBURatesService.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import Alamofire

class NBURatesService: RatesServiceProtocol {
    func loadList(param: String, completion: @escaping (([CurrencyRate], Error?) -> ()))
    {
        Alamofire.request(String(format:"https://www.bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date=%@&json",param),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let result = result as? [[String:AnyObject]]
                                {
                                    let rates = result.map{ CurrencyRate.init(dictionary: $0) }
                                    completion(rates,nil)
                                    
                                }
                                
                            case .failure(let error):
                                completion([], error)
                            }
        }
    }
    
    typealias Result = CurrencyRate
    
    
}
