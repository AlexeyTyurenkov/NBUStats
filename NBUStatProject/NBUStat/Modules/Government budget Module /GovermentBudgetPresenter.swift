//
//  GovermentBudgetPresenter.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/27/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class GovermentBudgetPresenter: NSObject, DateDependedPresenterProtocol, MonthDateDependedProtocol {
    weak var delegate: PresenterViewDelegate?
    
    
    private(set) var rates: [GovermentBudgetLine] = []
    private let service = GovermentBudgetService()
    let cellTypes: [BaseTableCellProtocol.Type] = [GovermentBudgetTableViewCell.self]
    
    var date: Date {
        didSet {
            if NSCalendar.current.compare(date, to: oldValue, toGranularity: .day) != .orderedSame
            {
                delegate?.presenterCancelSearch(self)
                loadList(date: date)
            }
        }
    }
    
    private func loadList(date: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        let dateString = dateFormatter.string(from: date)
        service.loadList(param: dateString) { (rates, error) in
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
    
    
    init(date: Date) {
        self.date = date
        super.init()
        registerSettingsBundle()
        updateDisplayFromDefaults()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NBUCurrencyRatesManager.defaultsChanged),
                                               name: UserDefaults.didChangeNotification,
                                               object: nil)
        
    }
    
    func set(rates: [GovermentBudgetLine])
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
        loadList(date: date)
    }
    
}

extension GovermentBudgetPresenter: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GovermentBudgetTableViewCell.CellIdentifier()) as? GovermentBudgetTableViewCell
        //cell?.configure(rate: rates[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}
