//
//  CurrencyRateTableViewCell.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyRateTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyFullName: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currenceRateLabel: UILabel!
    @IBOutlet weak var oldRate: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CurrencyRateTableViewCell
{
    func configure(currencyRate: CurrencyRate)
    {
        currencyName.text = currencyRate.cc
        currencyFullName.text = currencyRate.name
        currenceRateLabel.text = currencyRate.todayRate
        oldRate.text = currencyRate.yesterdayRate
        differenceLabel.text = currencyRate.difference
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
