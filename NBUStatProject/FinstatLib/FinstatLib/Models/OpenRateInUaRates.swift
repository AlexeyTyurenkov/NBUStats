//
//  OpenRateInUaRates.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/21/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

class OpenRateInUaRates
{
    var rates:[OpenRateInUaRate]
    
    init(rates: [String:AnyObject]) {
        
        self.rates = rates.enumerated().flatMap{ OpenRateInUaRate.init(name: $1.key, dictionary: ($1.value as? [String : Any])) }
        
    }
}
