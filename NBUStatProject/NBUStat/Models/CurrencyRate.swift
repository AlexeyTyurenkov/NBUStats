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
        rate = String(format: "%@", (dictionary["rate"] as? NSNumber) ?? 0)
        cc = (dictionary["cc"] as? String) ?? ""
        exchangedate = (dictionary["exchangedate"] as? String) ?? ""
    }
    
}
