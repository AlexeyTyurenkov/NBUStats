//
//  UXCurrentIndexInteractor.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/6/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import Alamofire

public class UXCurrentIndexInteractor
{
    public func load(completion: @escaping (([UXCurrencyIndexModel], Error?) -> ()))
    {
        Alamofire.request(String(format:"https://finstat.space/api/ux/index"),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let result = result as? [String:Any]
                                {
                                    completion([UXCurrencyIndexModel(dictionary: result)],nil)
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
}
