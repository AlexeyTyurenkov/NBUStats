//
//  UXCurrentIndexModuleBuilder.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/5/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class UXCurrentIndexModuleBuilder: ModuleBuilderProtocol {
    func viewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "UXCurrentIndex", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        if let navigationController =  initialController as? UINavigationController
        {
            if let controller = navigationController.topViewController as? UXCurrentIndexViewController
            {
                let presenter = UXCurrentIndexPresenter()
                let router    = UXCurrentIndexRouter()
                presenter.router = router
                controller.presenter = presenter
                controller.presenter.delegate = controller
            }
        }
        return initialController ?? UIViewController()
    }
    
    var moduleName: String
    {
        return NSLocalizedString("Український біржевий індекс\n(\"За даними Українскої біржи\")", comment: "")
    }
}
