//
//  NBURatesTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import FinstatLib

class NBURatesTableViewCell: UITableViewCell, BaseTableCellProtocol {

    
    @IBOutlet weak var currencyFullName: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyRateCaption: UILabel!
    @IBOutlet weak var currenceRateLabel: UILabel!
    @IBOutlet weak var oldRateCaption: UILabel!
    @IBOutlet weak var oldRate: UILabel!
    @IBOutlet weak var differenceCaption: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    
    static func CellIdentifier() -> String
    {
        return "NBURatesTableViewCell"
    }
    
    static func Nib() -> UINib
    {
        return UINib(nibName: "NBURatesTableViewCell", bundle: nil)
    }
}


extension NBURatesTableViewCell
{
    func configure(currencyRate: CurrencyRate, isProfessional:Bool)
    {
        currencyName.text = currencyRate.cc
        currencyFullName.text = currencyRate.name
        currenceRateLabel.text = currencyRate.todayRate
        oldRate.text = currencyRate.yesterdayRate
        differenceLabel.text = currencyRate.difference
        
        
        oldRateCaption.text = currencyRate.yesterdayDate
        differenceCaption.text = "Різниця"
        currencyRateCaption.text = currencyRate.exchangedate
        
        differenceCaption.isHidden = isProfessional
        oldRateCaption.isHidden = isProfessional
        currencyRateCaption.isHidden = isProfessional
        
        
        switch currencyRate.change() {
        case .goesdown:
            differenceLabel.textColor = ThemeManager.shared.negativeColor
        case .grow:
            differenceLabel.textColor = ThemeManager.shared.positiveColor
        case .same:
            differenceLabel.textColor = ThemeManager.shared.negativeColor
        default:
            differenceLabel.textColor = UIColor.clear
        }
    }
    

}
