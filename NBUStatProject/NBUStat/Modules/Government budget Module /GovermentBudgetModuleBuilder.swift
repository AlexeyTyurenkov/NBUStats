//
//  GovermentBudgetModuleBuilder.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/27/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class GovermentBudgetModuleBuilder: ModuleBuilderProtocol
{
    func viewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "CurrencyRates", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        if let navigationController =  initialController as? UINavigationController
        {
            if let controller = navigationController.topViewController as? CurrencyViewController
            {
                controller.presenter = GovermentBudgetPresenter(date: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date())
            }
        }
        return initialController ?? UIViewController()
    }
    
    var moduleName: String
    {
        return NSLocalizedString("Державні фінанси", comment: "")
    }
    
    
}

