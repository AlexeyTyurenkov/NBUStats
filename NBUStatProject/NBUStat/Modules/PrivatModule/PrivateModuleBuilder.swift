//
//  PrivateModuleBuilder.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/11/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class PrivateModuleBuilder: ModuleBuilderProtocol
{
    func viewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "PrivatCurrencyRates", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        if let navigationController =  initialController as? UINavigationController
        {
            if let controller = navigationController.topViewController as? PrivateCurrencyViewController
            {
                let presenter = PrivateCurrencyRatesPresenter()
                let router    = PrivateCurrencyRatesRouter()
                presenter.router = router
                controller.presenter = presenter
                controller.presenter.delegate = controller
            }
        }
        return initialController ?? UIViewController()
    }
    
    var moduleName: String
    {
        return NSLocalizedString("Курси валют Приват Банку", comment: "")
    }
}
