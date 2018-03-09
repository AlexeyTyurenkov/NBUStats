//
//  HryvniaTodayService.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import Alamofire

public class HryvniaTodayService: RatesServiceProtocol {
    public func loadList(param: String, completion: @escaping (([Result], Error?) -> ()))
    {
        Alamofire.request(String(format:endpoint,param),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let resultJSON = result as? [String:Any],
                                    let result = resultJSON["data"] as? [Any]
                                {
                                    
                                    let rates = result.flatMap{ Result.init(dictionary: ($0 as? [String:Any])) }
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
    
    var endpoint: String! {
        return nil
    }
    public typealias Result = HrTodayRate
    
    public init () {}
}

public class InterbankHTService: HryvniaTodayService {
    override var endpoint: String! { return "https://finstat.space/api/ht/interbank"}
}

public class CommercialHTService: HryvniaTodayService {
    override var endpoint: String!{ return "https://finstat.space/api/ht/commercial"}
}

public class BlackHTService: HryvniaTodayService {
    override var endpoint: String! { return "https://finstat.space/api/ht/black"}
}

