//
//  ProviderTableViewCell+MainScreenCellProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/18/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

extension ProviderTableViewCell: MainScreenCellProtocol
{
    func configure(withTitle title: String) {
        self.title.text = title
        self.title.textColor = ThemeManager.shared.neutralColor
    }
}
