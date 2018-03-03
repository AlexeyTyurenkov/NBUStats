//
//  String+DifferenceComparationResult.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/3/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

extension String
{
    func comparation(with: Float) -> DifferenceComparisonResult
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 3
        formatter.decimalSeparator = "."
        let number = formatter.number(from: self) ?? NSNumber(integerLiteral: 0)
        var result:DifferenceComparisonResult = .unknown
        if number.floatValue > with
        {
            result = .goesdown
        }
        else if (number.floatValue < with)
        {
            result = .grow
        }
        else
        {
            result = .same
        }
        return result
    }
}
