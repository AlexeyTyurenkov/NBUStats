//
//  OpenRateInUaRate.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/21/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

/*{"USD":{"interbank":{"buy":"26.77","sell":"26.79"}},"EUR":{"interbank":{"buy":"31.3797","sell":"31.4032"}},"RUB":{"interbank":{"buy":"0.4653","sell":"0.4662"}}}*/

typealias InterbankRate = (buy: String, sell: String)


public struct OpenRateInUaRate
{
    public var code: String
    public var buy: String
    public var sell: String
    
    init?(name: String, dictionary:[String:Any]?)
    {
        // {"interbank":{"buy":"26.77","sell":"26.79"}}
        guard let data = dictionary?["interbank"] as? [String:String] else { return nil }
        code = name
        buy = data["buy"] ?? "N/A"
        sell = data["sell"] ?? "N/A"
    }
}
