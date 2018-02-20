//
//  ProviderTableViewCell.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/18/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit




class ProviderTableViewCell: UITableViewCell, BaseTableCellProtocol {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func CellIdentifier() -> String
    {
        return "ProviderTableViewCell"
    }
    
    static func Nib() -> UINib
    {
        return UINib(nibName: "ProviderTableViewCell", bundle: nil)
    }
}


