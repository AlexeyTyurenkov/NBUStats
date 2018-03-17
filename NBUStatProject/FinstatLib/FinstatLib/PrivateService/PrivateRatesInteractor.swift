//
//  PrivateRatesInteractor.swift
//  FinstatLib
//
//  Created by Aleksey Tyurenkov on 3/17/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import Alamofire

public class PrivateRatesInteractor: RatesServiceProtocol
{

    
    public func loadList(param: String, completion: @escaping (([Result], Error?) -> ()))
    {
        Alamofire.request(String(format:endPoint),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let resultJSON = result as? [[String:Any]]
                                {
                                    
                                    let rates = resultJSON.flatMap{ Result.init(dictionary: $0) }
                                    completion(rates,nil)
                                }
                                else
                                {
                                    completion([],nil)
                                }
                            case .failure(let error):
                                completion([], error)
                            }
        }
    }
    
    public init() {}
    public typealias Result = PrivateRate
    var endPoint:String {
        return "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11"
    }
}


public class PrivateCashRatesInteractor: PrivateRatesInteractor
{
    override var endPoint:String {
        return "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    }
}
