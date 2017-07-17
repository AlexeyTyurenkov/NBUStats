//
//  CurrencyRate.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

/*
 
 {"r030":682,"txt":"Саудівський рiял","rate":7.016464,"cc":"SAR","exchangedate":"14.07.2017"}
 */
enum DifferenceComparisonResult
{
    case same
    case grow
    case goesdown
    case unknown
}


class CurrencyRate
{
    var r030: String = ""
    var name: String = ""
    var newRate: NSNumber = 0.0
    var cc: String = ""
    var exchangedate: String = ""
    var oldRate: NSNumber?

    private var formatter: NumberFormatter
    
    init(dictionary: [String:AnyObject]) {
        r030 = String(format: "%i", (dictionary["r030"] as? Int) ?? 0)
        name = (dictionary["txt"] as? String) ?? ""
        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 8
        self.newRate = NSNumber(value: (dictionary["rate"] as? Double ?? 0.0)) //
        cc = (dictionary["cc"] as? String) ?? ""
        exchangedate = (dictionary["exchangedate"] as? String) ?? ""
    }
    
    func contains(_ searchTerm: String) -> Bool
    {
        let localizedTerm = searchTerm.localizedLowercase
        return (searchTerm == "" || cc.lowercased().contains(localizedTerm) || name.lowercased().contains(localizedTerm) || r030.lowercased().contains(localizedTerm))
    }
    
    var todayRate: String
    {
        return formatted(number: newRate)
    }
    
    var yesterdayRate: String
    {
        return formatted(number: oldRate)
    }
    
    var difference: String
    {
        guard let oldRate = oldRate else { return ""}
        let diff = newRate.decimalValue - oldRate.decimalValue
        return formatted(number: diff as NSNumber)
    }
    
    private func formatted(number: NSNumber?) -> String
    {
        guard let number = number else { return "" }
        return formatter.string(from: number) ?? ""
    }
    
    func change() -> DifferenceComparisonResult
    {
        guard let oldrate = oldRate else { return .unknown }
        let diff =  newRate.decimalValue - oldrate.decimalValue
        if diff > 0
        {
            return .goesdown
        }
        if diff < 0
        {
            return .grow
        }
        return .same
    }
    
    static func >(lhs:CurrencyRate, rhs: CurrencyRate)->Bool
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard let ldate = formatter.date(from: lhs.exchangedate) else { return false }
        guard let rdate = formatter.date(from: rhs.exchangedate) else { return true }
        return ldate.compare(rdate) == ComparisonResult.orderedAscending
    }
}
