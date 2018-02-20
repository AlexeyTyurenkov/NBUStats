//
//  BaseTableCellProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit


protocol BaseTableCellProtocol {
    static func CellIdentifier() -> String
    static func Nib() -> UINib
}

