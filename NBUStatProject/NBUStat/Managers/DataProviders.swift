//
//  DataProviders.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/18/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


class DataProviders
{
    private let dataProviders = ["Курси НБУ", "Курси міжбанку"]
    
    var count: Int {
        return dataProviders.count
    }
    
    func title(at index: Int) -> String {
        guard index >= 0 && index < count else { return "" }
        return dataProviders[index]
    }
    
}
