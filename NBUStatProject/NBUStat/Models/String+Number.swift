//
//  String+Number.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

extension String
{
    func number(_ scale: Int = 3) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = scale
        formatter.decimalSeparator = "."
        let number = formatter.number(from: self) ?? NSNumber(integerLiteral: 0)
        return formatter.string(from: number) ?? "N/A"
    }
}
