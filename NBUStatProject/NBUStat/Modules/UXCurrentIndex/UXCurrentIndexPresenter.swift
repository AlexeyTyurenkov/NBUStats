//
//  UXCurrentIndexPresenter.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/6/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import FinstatLib

enum IndexError:Error
{
    case general
}

protocol UXCurrentIndexPresenterProtocol: PresenterProtocol {
    func showDataProviderInfo()
}


class UXCurrentIndexPresenter: UXCurrentIndexPresenterProtocol
{
    weak var delegate: PresenterViewDelegate?
    var router: UXCurrentIndexRouter?
    var interactor = UXCurrentIndexInteractor()
    var currentModel: UXCurrencyIndexModel?
    func updateView() {
        
    }
    
    func viewLoaded() {
        interactor.load { (models, error) in
            guard error == nil else { self.delegate?.presenter(self, getError: error!); return }
            if let model = models.first
            {
                self.currentModel = model
                self.delegate?.presenter(self, updateAsProfessional: false)
            }
            else
            {
                self.delegate?.presenter(self, getError: IndexError.general)
            }
        }
    }
    
    var cellTypes: [BaseTableCellProtocol.Type] = []
    
    var dataProviderInfo: DataProviderInfoProtocol {
        return self
    }
    
    func showDataProviderInfo() {
        if let controller = delegate as? UXCurrentIndexViewController
        {
            router?.presentDataProviderInfo(from: controller, dataProviderInfo: dataProviderInfo)
        }
        
    }
}
