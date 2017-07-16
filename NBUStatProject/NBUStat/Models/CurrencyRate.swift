//
//  CurrencyRate.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

/*
 
 {"r030":682,"txt":"Саудівський рiял","rate":7.016464,"cc":"SAR","exchangedate":"14.07.2017"}
 */

class CurrencyRate
{
    var r030: String = ""
    var name: String = ""
    var rate: String = ""
    var cc: String = ""
    var exchangedate: String = ""
    
    init(dictionary: [String:AnyObject]) {
        r030 = String(format: "%i", (dictionary["r030"] as? Int) ?? 0)
        name = (dictionary["txt"] as? String) ?? ""
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 8
        let rate = NSNumber(value: (dictionary["rate"] as? Double ?? 0.0))
        self.rate = formatter.string(from: rate) ?? ""
        cc = (dictionary["cc"] as? String) ?? ""
        exchangedate = (dictionary["exchangedate"] as? String) ?? ""
    }
    
    func contains(_ searchTerm: String) -> Bool
    {
        let localizedTerm = searchTerm.localizedLowercase
        return (searchTerm == "" || cc.lowercased().contains(localizedTerm) || name.lowercased().contains(localizedTerm) || r030.lowercased().contains(localizedTerm))
    }
    
}
