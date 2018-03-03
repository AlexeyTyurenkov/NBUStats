//
//  NBUCurrencyRatesManager+DataProviderInfo.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/3/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


extension NBUCurrencyRatesManager: DataProviderInfoProtocol
{
    var link: URL {
        return URL(string: "https://bank.gov.ua")!
    }
    
    var text: String {
        return "Дані отримано з офіційного API Національного банку України."
    }
    
    var title: String {
        return "Національний Банк України"
    }
    
    
}
