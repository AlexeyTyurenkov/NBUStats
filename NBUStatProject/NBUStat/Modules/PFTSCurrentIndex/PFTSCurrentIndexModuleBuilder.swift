//
//  UXCurrentIndexModuleBuilder.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/5/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class PFTSCurrentIndexModuleBuilder: ModuleBuilderProtocol {
    func viewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "PFTSCurrentIndex", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        if let navigationController =  initialController as? UINavigationController
        {
            if let controller = navigationController.topViewController as? PFTSCurrentIndexViewController
            {
                let presenter = PFTSCurrentIndexPresenter()
                let router    = PFTSIndexRouter()
                presenter.router = router
                controller.presenter = presenter
                controller.presenter.delegate = controller
            }
        }
        return initialController ?? UIViewController()
    }
    
    var moduleName: String
    {
        return NSLocalizedString("Біржевий індекс ПФТС\n(\"За даними ПАТ ПФТС\")", comment: "")
    }
}
