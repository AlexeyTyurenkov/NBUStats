//
//  HrTodayTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class HrTodayTableViewCell: UITableViewCell, BaseTableCellProtocol {
    static func CellIdentifier() -> String {
        return "HrTodayTableViewCell"
    }
    
    static func Nib() -> UINib {
        return UINib(nibName: "HrTodayTableViewCell", bundle: nil)
    }
    


    
}
