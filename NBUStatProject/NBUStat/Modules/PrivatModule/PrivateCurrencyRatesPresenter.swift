//
//  PrivateCurrencyRatesPresenter.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/11/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


protocol PrivateCurrencyRatesViewOutput: class
{
    
}

class PrivateCurrencyRatesPresenter: PresenterProtocol,PrivateCurrencyRatesViewOutput
{
    weak var delegate: PresenterViewDelegate?
    weak var viewInput: AnyObject?
    var router: PrivateCurrencyRatesRouter!
    
    func updateView() {
        
    }
    
    func viewLoaded() {
    
    }
    
    var dataProviderInfo: DataProviderInfoProtocol {
        return self
    }
   
    func showDataProviderInfo() {
        if let controller = delegate as? PFTSCurrentIndexViewController
        {
            router?.presentDataProviderInfo(from: controller, dataProviderInfo: dataProviderInfo)
        }
        
    }
    
}
