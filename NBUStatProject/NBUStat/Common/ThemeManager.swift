//
//  ThemeManager.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/7/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

typealias ColorSet = (positive: UIColor, negative: UIColor, same: UIColor)

class ThemeManager
{
    static let shared = ThemeManager()
    
    private init()
    {
        
    }
    
    var negativeColor = UIColor(red: 213.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    var positiveColor = UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0)
    var neutralColor  = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    
    var defaultColorSet: ColorSet {
        return (positive: positiveColor, negative: negativeColor, same: neutralColor)
    }
    
}
