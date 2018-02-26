//
//  InterbankRatesTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/21/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class InterbankRatesTableViewCell:UITableViewCell, BaseTableCellProtocol {

    @IBOutlet weak var currencyName: UILabel!
    
    @IBOutlet weak var sell: UILabel!
    
    @IBOutlet weak var buy: UILabel!
    
    
    static func CellIdentifier() -> String
    {
        return "InterbankRatesTableViewCell"
    }
    static func Nib() -> UINib
    {
         return UINib(nibName: "InterbankRatesTableViewCell", bundle: nil)
    }
}


extension InterbankRatesTableViewCell
{
    func configure(rate: OpenRateInUaRate)
    {
        currencyName.text = rate.code
        sell.text = rate.sell
        buy.text = rate.buy
    }
}
