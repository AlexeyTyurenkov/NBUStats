//
//  UXCurrencyIndexModel.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/6/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


struct UXCurrencyIndexModel
{
    /*{"id":1,"open":"1595.93","max":"1629.23","min":"1594.04","close":"1616.34","prev":"1595.59","openchange":"1.28","prevchange":"1.3","volume":"290862866","moment":"2018-03-05 17:00:00","created_at":"2018-03-05 07:17:01","updated_at":"2018-03-05 15:08:01"}*/
    
    var moment: String
    var open: String
    var max: String
    var min: String
    var close: String
    var change: String
    
    init(dictionary: [String:Any])
    {
        moment = (dictionary["moment"] as? String) ?? ""
        open = (dictionary["open"] as? String) ?? ""
        max = (dictionary["max"] as? String) ?? ""
        min = (dictionary["min"] as? String) ?? ""
        close = (dictionary["close"] as? String) ?? ""
        change = (dictionary["openchange"] as? String) ?? ""
    }
}
