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
        let storyBoard = UIStoryboard(name: "CurrencyRates", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        if let navigationController =  initialController as? UINavigationController
        {
            if let controller = navigationController.topViewController as? CurrencyViewController
            {
                controller.presenter = NBUCurrencyRatesManager(date: Date())
            }
        }
        return initialController ?? UIViewController()
    }
    
    var moduleName: String
    {
        return NSLocalizedString("Курси НБУ", comment: "")
    }
}
