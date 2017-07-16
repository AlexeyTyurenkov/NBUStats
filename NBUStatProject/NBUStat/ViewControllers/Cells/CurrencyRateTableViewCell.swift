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
    }
}
