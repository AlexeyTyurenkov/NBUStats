//
//  GovermentBudgetLine.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/27/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


struct GovermentBudgetLine
{
    var txt: String
    var txten: String
    var id_api: String
    var leveli: Int
    var parent: String
    var mcr200p: String
    var value: NSNumber
    private var formatter: NumberFormatter
    
    init(dictionary: [String:AnyObject]) {
        txt = (dictionary["text"] as? String) ?? ""
        txten = (dictionary["txten"] as? String) ?? ""
        id_api = (dictionary["id_api"] as? String) ?? ""
        leveli = (dictionary["leveli"] as? Int) ?? -1
        parent = (dictionary["parent"] as? String) ?? ""
        mcr200p = (dictionary["mcr200p"] as? String) ?? ""
        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 8
        value = NSNumber(value: (dictionary["value"] as? Double ?? 0.0))
    }
    
}
