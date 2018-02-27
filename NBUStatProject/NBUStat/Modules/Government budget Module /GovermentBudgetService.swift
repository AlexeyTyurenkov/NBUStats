//
//  GovermentBudgetService.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/27/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import Alamofire

class GovermentBudgetService: RatesServiceProtocol {
    func loadList(param: String, completion: @escaping (([GovermentBudgetLine], Error?) -> ()))
    {
        Alamofire.request(String(format:"https://bank.gov.ua/NBUStatService/v1/statdirectory/budget?period=m&date=%@&json",param),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let result = result as? [Any]
                                {
                                    let rates = result.flatMap{ GovermentBudgetLine.init(dictionary: ($0 as! [String:AnyObject])) }
                                    completion(rates,nil)
                                    
                                }
                            case .failure(let error):
                                completion([], error)
                            }
        }
    }
    
    typealias Result = GovermentBudgetLine
    
    
}
