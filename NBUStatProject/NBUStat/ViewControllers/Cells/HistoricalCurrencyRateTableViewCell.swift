//
//  HistoricalCurrencyRateTableViewCell.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/17/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import FinstatLib

class HistoricalCurrencyRateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(rate: CurrencyRate)
    {
        dateLabel.text = rate.exchangedate
        rateLabel.text = rate.todayRate
    }
    
}
