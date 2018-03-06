//
//  UXCurrentIndexPresenter+DataProviderInfo.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/6/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

extension UXCurrentIndexPresenter: DataProviderInfoProtocol
{
    var link: URL {
        return URL(string:"https://m.ux.ua")!
    }
    
    var text: String {
        return "ПАТ «Українська біржа» — фондова біржа цінних паперів України."
    }
    
    var title: String {
        return "ПАТ \"Українска біржа\""
    }
    
    
    
}
