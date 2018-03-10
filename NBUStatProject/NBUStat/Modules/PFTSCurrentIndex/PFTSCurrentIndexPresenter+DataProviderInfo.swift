//
//  UXCurrentIndexPresenter+DataProviderInfo.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/6/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

extension PFTSCurrentIndexPresenter: DataProviderInfoProtocol
{
    var link: URL {
        return URL(string:"https://PFTS.ua")!
    }
    
    var text: String {
        return "Біржа ПФТС є одним з найбільших організаторів торгівлі на ринку цінних паперів України; підтримує міжрегіональну систему електронних торгів цінними паперами в режимі реального часу."
    }
    
    var title: String {
        return "ПАТ «Фондова біржа ПФТС»"
    }
    
    
    
}
