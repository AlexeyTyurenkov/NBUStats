//
//  GovermentBudgetLine.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/27/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


public struct GovermentBudgetLine
{
    public var txt: String
    public var txten: String
    public var id_api: String
    public var leveli: Int
    public var parent: String
    public var mcr200p: String
    public var value: NSNumber
    private var formatter: NumberFormatter
    
    public init(dictionary: [String:AnyObject]) {
        txt = (dictionary["txt"] as? String) ?? ""
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
