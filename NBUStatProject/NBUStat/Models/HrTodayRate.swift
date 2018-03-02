//
//  HrTodayRate.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

struct HrTodayRate
{
    var code: String
    var buy: String
    var sell: String
    var buyChange: String
    var sellChange: String
    var name: String
    var updated: String
    
    init?(dictionary:[String:Any]?)
    {
        /*
 {
 "id": 54,
 "cc": "643",
 "buy": "0.468100000",
 "buychange": "-0.0049",
 "sale": "0.472100000",
 "salechange": "-0.00455",
 "day": "2018-03-01",
 "type": 3,
 "created_at": "2018-03-01 21:21:38",
 "updated_at": "2018-03-01 21:21:38"
 }
 */
        guard let code = dictionary?["cc"] as? String else { return nil}
        guard let updated = dictionary?["updated_at"] as? String else { return nil}
        self.updated = updated.UTCToLocal()
        self.code = code
        self.name = dictionary?["name"] as? String ?? CurrencyName.by(code: code)
        buy = dictionary?["buy"] as? String ?? ""
        sell = dictionary?["sale"] as? String ?? ""
        buyChange = dictionary?["buychange"] as? String ?? ""
        sellChange = dictionary?["salechange"] as? String ?? ""

    }
    
    
    
    
}
