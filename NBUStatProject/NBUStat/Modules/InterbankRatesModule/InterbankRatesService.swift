//
//  InterbankRatesService.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/21/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class InterbankRatesService: RatesServiceProtocol {
    func loadList(param: String, completion: @escaping (([OpenRateInUaRate], Error?) -> ()))
    {
        Alamofire.request(String(format:"http://openrates.in.ua/rates?date=%@   ",param),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let result = result as? [String:AnyObject]
                                {
                                    let rates = result.enumerated().flatMap{ OpenRateInUaRate.init(name: $1.key, dictionary: ($1.value as? [String : Any])) }
                                    completion(rates,nil)
                                    
                                }
                                
                                
                            case .failure(let error):
                                completion([], error)
                            }
        }
    }
    
    typealias Result = OpenRateInUaRate
    
    
}
