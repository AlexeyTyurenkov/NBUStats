//
//  UILabel+Colorification.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/3/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

typealias ColorSet = (positive: UIColor, negative: UIColor, same: UIColor)


extension UILabel{
    func set(value:String, colorSet: ColorSet)
    {
        self.text = value
        switch value.comparation(with: 0) {
        case .goesdown:
            //rgba(231, 76, 60,1.0)
            self.textColor = colorSet.negative
        case .grow:
            //rgba(26, 188, 156,1.0)
            self.textColor = colorSet.positive
        case .same:
            //rgba(52, 73, 94,1.0)
            self.textColor = colorSet.same
        default:
            self.textColor = UIColor.clear
        }
    }
}
