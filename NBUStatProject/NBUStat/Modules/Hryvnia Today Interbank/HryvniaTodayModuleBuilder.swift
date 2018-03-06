//
//  HryvniaTodayModuleBuilder.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit
class HryvniaTodayModuleBuilder: ModuleBuilderProtocol
{
    
    var presenter: TablePresenterProtocol! { return nil }
    func viewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "Currencies", bundle: nil)
        let initialController = storyBoard.instantiateInitialViewController()
        if let navigationController =  initialController as? UINavigationController
        {
            if let controller = navigationController.topViewController as? ContainerViewController
            {
                controller.navigationItem.title = self.moduleName
                controller.presenter = presenter
            }
        }
        return initialController ?? UIViewController()
    }
    
    var moduleName: String
    {
        return NSLocalizedString("", comment: "")
    }
}

class InterbankHTModuleBuilder: HryvniaTodayModuleBuilder
{
    override var presenter: TablePresenterProtocol! {
        let presenter = HryvniaTodayPresenter()
        presenter.service = InterbankHTService()
        return presenter
        
    }
    
    override var moduleName: String{
        return NSLocalizedString("Оперативні курси валют на Miжбанку\n(Hryvna.Today)", comment: "")
    }
}

class BlackHTModuleBuilder: HryvniaTodayModuleBuilder
{
    override var presenter: TablePresenterProtocol! {
        let presenter = HryvniaTodayPresenter()
        presenter.service = BlackHTService()
        return presenter
        
    }
    
    override var moduleName: String{
        return NSLocalizedString("Очікування готівкого ринку\n(Hryvna.Today)", comment: "")
    }
}

class CommercialHTModuleBuilder: HryvniaTodayModuleBuilder
{
    override var presenter: TablePresenterProtocol! {
        let presenter = HryvniaTodayPresenter()
        presenter.service = CommercialHTService()
        return presenter
        
    }
    
    override var moduleName: String{
        return NSLocalizedString("Оперативні середні готівкові курси по банках\n(Hryvna.Today)", comment: "")
    }
}
