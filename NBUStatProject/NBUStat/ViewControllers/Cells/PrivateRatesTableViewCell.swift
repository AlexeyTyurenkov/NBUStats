//
//  PrivateRatesTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/17/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import FinstatLib

class PrivateRatesTableViewCell: UITableViewCell, BaseTableCellProtocol {

    static func CellIdentifier() -> String {
        return "PrivateRatesTableViewCell"
    }
    
    static func Nib() -> UINib {
        return UINib(nibName: "PrivateRatesTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var base: UILabel!
    @IBOutlet weak var updated: UILabel!
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sale: UILabel!
    
    
    func configure(line: PrivateRate)
    {
        currency.text = line.currency
        base.text = line.base
        buy.text = line.buy.number()
        sale.text = line.sale.number()
        updated.text = line.updated
    }

}
