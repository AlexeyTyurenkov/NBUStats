//
//  DataProviders.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/18/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class ModuleProvider
{
    private let dataProviders: [ModuleBuilderProtocol] = [NBUCurrencyModuleBuilder(),
                                 InterbankRatesModuleBuilder()
                                 ]
    
    var count: Int {
        return dataProviders.count
    }
    
    func title(at index: Int) -> String {
        guard index >= 0 && index < count else { return "" }
        return dataProviders[index].moduleName
    }
    
    func viewController(at index: Int) -> UIViewController? {
        guard index >= 0 && index < count else { return nil }
        return dataProviders[index].viewController()
    }
    
    func firstController() -> UIViewController {
        return viewController(at:0) ?? UIViewController()
    }
}
