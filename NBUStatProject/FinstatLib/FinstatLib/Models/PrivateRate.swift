//
//  PrivateRate.swift
//  FinstatLib
//
//  Created by Aleksey Tyurenkov on 3/17/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
public struct PrivateRate
{
    /*[{"ccy":"USD","base_ccy":"UAH","buy":"26.35000","sale":"26.65000"},{"ccy":"EUR","base_ccy":"UAH","buy":"32.40000","sale":"32.90000"},{"ccy":"RUR","base_ccy":"UAH","buy":"0.45000","sale":"0.47000"},{"ccy":"BTC","base_ccy":"USD","buy":"8076.5284","sale":"8926.6892"}]*/
    
    public var currency: String
    public var base: String
    public var buy: String
    public var sale: String
    public var updated: String
    
    
    public init(dictionary: [String:Any])
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MMM.yyyy"
        updated = dateFormatter.string(from: Date())
        base = (dictionary["base_ccy"] as? String) ?? ""
        currency = (dictionary["ccy"] as? String) ?? ""
        buy = (dictionary["buy"] as? String) ?? ""
        sale = (dictionary["sale"] as? String) ?? ""
    }
}
