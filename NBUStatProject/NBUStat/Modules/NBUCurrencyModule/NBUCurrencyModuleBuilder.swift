//
//  NBUCurrencyModuleBuilder.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class NBUCurrencyModuleBuilder: ModuleBuilderProtocol {
    func viewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "MainMasterDetail", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "CurrencyNavigatoinController")
    }
    
    var moduleName: String
    {
        return NSLocalizedString("Курси НБУ", comment: "")
    }
}