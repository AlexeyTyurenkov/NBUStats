//
//  PrivateRatesTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/17/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import FinstatLib

class PrivateRatesTableViewCell: UITableViewCell,BaseTableCellProtocol {

    static func CellIdentifier() -> String {
        return "PrivateRatesTableViewCell"
    }
    
    static func Nib() -> UINib {
        return UINib(nibName: "PrivateRatesTableViewCell", bundle: nil)
    }
    
    
    func configure(line: PriveteRate)
    {
//        nameLabel.text = line.name
//        buyLabel.text = line.buy.number()
//        cellLabel.text = line.sell.number()
//        changeBuyLabel.set(value:line.buyChange.number(5), colorSet: ThemeManager.shared.defaultColorSet)
//        changeSellLAbel.set(value:line.sellChange.number(5), colorSet: ThemeManager.shared.defaultColorSet)
//        update.text = line.updated
    }

}
