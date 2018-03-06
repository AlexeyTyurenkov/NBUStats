//
//  HrTodayTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class HrTodayTableViewCell: UITableViewCell, BaseTableCellProtocol {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var changeBuyLabel: UILabel!
    @IBOutlet weak var changeSellLAbel: UILabel!
    @IBOutlet weak var update: UILabel!
    static func CellIdentifier() -> String {
        return "HrTodayTableViewCell"
    }
    
    static func Nib() -> UINib {
        return UINib(nibName: "HrTodayTableViewCell", bundle: nil)
    }
    

    func configure(line: HrTodayRate)
    {
        nameLabel.text = line.name
        buyLabel.text = line.buy.number()
        cellLabel.text = line.sell.number()
        changeBuyLabel.set(value:line.buyChange.number(5), colorSet: ThemeManager.shared.defaultColorSet)
        changeSellLAbel.set(value:line.sellChange.number(5), colorSet: ThemeManager.shared.defaultColorSet)
        update.text = line.updated
    }

    
}
