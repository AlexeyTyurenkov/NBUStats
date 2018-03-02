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
        changeBuyLabel.set(value:line.buyChange.number(5), colorSet: (positive: UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0), negative: UIColor(red: 213.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), same: UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)))
        changeSellLAbel.set(value:line.sellChange.number(5), colorSet: (positive: UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0), negative: UIColor(red: 213.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), same: UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)))
        update.text = line.updated
    }

    
}
