//
//  PrivateCurrencyRatesPresenter.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/11/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import FinstatLib

protocol PrivateCurrencyRatesViewOutput: class
{
    
}

class PrivateCurrencyRatesPresenter: NSObject, PrivateCurrencyRatesViewOutput, TablePresenterProtocol
{
    weak var delegate: PresenterViewDelegate?
    weak var viewInput: AnyObject?
    var router: PrivateCurrencyRatesRouter!
    var interactors: [PrivateRatesInteractor] = [PrivateRatesInteractor(), PrivateCashRatesInteractor()]
    private(set) var rates: [PrivateRate] = []
    let cellTypes: [BaseTableCellProtocol.Type] = [HrTodayTableViewCell.self]
    
    func updateView() {
        
    }
    
    func viewLoaded() {
        load(index: 0)
    }
    
    var dataProviderInfo: DataProviderInfoProtocol {
        return self
    }
   
    func showDataProviderInfo() {
        if let controller = delegate as? PrivateCurrencyViewController 
        {
            router?.presentDataProviderInfo(from: controller, dataProviderInfo: dataProviderInfo)
        }
        
    }
    
    func load(index: Int)
    {
        delegate?.presenterWillLoad(self)
        interactors[index].loadList(param: "") { (rates, error) in
            if let error = error
            {
                self.delegate?.presenter(self, getError: error)
            }
            else
            {
                self.set(rates: rates)
            }
        }
    }
    
    func set(rates: [PrivateRate])
    {
        self.rates = rates
        delegate?.presenter(self, updateAsProfessional: false)
    }
    
    
}


extension PrivateCurrencyRatesPresenter: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PrivateRatesTableViewCell.CellIdentifier()) as? PrivateRatesTableViewCell
        cell?.configure(line: rates[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}
