//
//  GovermentBudgetTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/1/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class GovermentBudgetTableViewCell: UITableViewCell, BaseTableCellProtocol {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    static func CellIdentifier() -> String {
        return "GovermentBudgetTableViewCell"
    }
    
    static func Nib() -> UINib {
        return UINib(nibName: "GovermentBudgetTableViewCell", bundle: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GovermentBudgetTableViewCell
{
    func configure(line: GovermentBudgetLine)
    {
        name.text = line.txt
        value.text = line.value.stringValue
    }
}
