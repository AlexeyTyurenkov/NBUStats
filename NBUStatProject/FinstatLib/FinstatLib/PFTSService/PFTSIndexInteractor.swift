//
//  PFTSIndexInteractor.swift
//  FinstatLib
//
//  Created by Aleksey Tyurenkov on 3/10/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import Alamofire

public class PFTSIndexInteractor
{
    public func load(completion: @escaping (([PFTSIndexModel], Error?) -> ()))
    {
        Alamofire.request(String(format:"https://finstat.space/api/pfts/index"),
                          method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                            switch response.result
                            {
                            case .success(let result):
                                if let result = result as? [String:Any]
                                {
                                    completion([PFTSIndexModel(dictionary: result)],nil)
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
