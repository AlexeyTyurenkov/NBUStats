//
//  HryvniaTodayPresenter.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/2/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

class HryvniaTodayPresenter: NSObject, PresenterProtocol {
    weak var delegate: PresenterViewDelegate?
    
    
    private(set) var rates: [HrTodayRate] = []
    var service: HryvniaTodayService!
    let cellTypes: [BaseTableCellProtocol.Type] = [HrTodayTableViewCell.self]
    

    
    private func loadList()
    {
        service.loadList(param: "") { (rates, error) in
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
    
    
    override init() {
        super.init()
        registerSettingsBundle()
        updateDisplayFromDefaults()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NBUCurrencyRatesManager.defaultsChanged),
                                               name: UserDefaults.didChangeNotification,
                                               object: nil)
        
    }
    
    func set(rates: [HrTodayRate])
    {
        self.rates = rates
        delegate?.presenter(self, updateAsProfessional: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        
        //NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func updateDisplayFromDefaults(){
        delegate?.presenter(self, updateAsProfessional: false)
    }
    
    @objc func defaultsChanged(){
        updateDisplayFromDefaults()
    }
    
    func updateView() {
        delegate?.presenter(self, updateAsProfessional: false)
    }
    
    func viewLoaded() {
        loadList()
    }
    
    var dataProviderInfo: DataProviderInfoProtocol{
        return self
    }
    
}

extension HryvniaTodayPresenter: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HrTodayTableViewCell.CellIdentifier()) as? HrTodayTableViewCell
        cell?.configure(line: rates[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}
