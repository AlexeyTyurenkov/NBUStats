//
//  CurrencyName.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

class CurrencyName
{
    static func by(code: String) -> String
    {
        switch code {
        case "840":
            return "Долар США"
        case "978":
            return "Євро"
        case "643":
            return "Російський рубль"
        default:
            return code
        }
        
    }
}
