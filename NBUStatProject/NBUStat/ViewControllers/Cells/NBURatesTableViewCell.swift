//
//  NBURatesTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

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
            //rgba(231, 76, 60,1.0)
            differenceLabel.textColor = UIColor(red: 213.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        case .grow:
            //rgba(26, 188, 156,1.0)
            differenceLabel.textColor = UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1.0)
        case .same:
            //rgba(52, 73, 94,1.0)
            differenceLabel.textColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        default:
            differenceLabel.textColor = UIColor.clear
        }
    }
    

}
