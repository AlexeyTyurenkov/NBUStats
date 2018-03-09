//
//  CurrencyDetailTableViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/17/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import Alamofire
import FinstatLib

class NBURateTableViewController: UITableViewController {

    
    var currency: String = ""
    let dateFormatter = DateFormatter()
    private var rates: [CurrencyRate] = []
    weak var delegate: CurrencyDetailContainerViewController? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyyMMdd"
        delegate?.showActivity()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            let dispatchGroup = DispatchGroup()
            let calendar = NSCalendar.current
            let startDate = Date() // first date
            //let endDate = Date() // last date
            var downloadedRates:[CurrencyRate] = []

            for i in 0...31
            {
                dispatchGroup.enter()
                let date = calendar.date(byAdding: .day, value: -1 * i, to: startDate)!
                let dateString = strongSelf.dateFormatter.string(from: date)
                let formattedString = String(format: "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode=%@&date=%@&json", strongSelf.currency, dateString)
                Alamofire.request(formattedString, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                    switch response.result
                    {
                    case .success(let results):
                        
                        if let results = results as? [[String:AnyObject]],
                            let result = results.first
                        {
                            let rate = CurrencyRate(dictionary: result)
                            downloadedRates.append(rate)
                        }
                    case .failure(let error):
                        let alert = UIAlertController(title: "Помилка завантаження", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in }))
                        DispatchQueue.main.async {
                            self?.present(alert, animated: true, completion: nil)
                        }
                    }
                    dispatchGroup.leave()
                }
               
            }
            dispatchGroup.wait()
            DispatchQueue.main.async {
                self?.rates = downloadedRates.sorted(by: { (lhs, rhs) -> Bool in
                    return rhs > lhs
                })
                strongSelf.tableView.reloadData()
                strongSelf.delegate?.hideActivity()
            }

        }
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricalCurrencyRateTableViewCell", for: indexPath)

        if let cell = cell as? HistoricalCurrencyRateTableViewCell
        {
            cell.configure(rate: rates[indexPath.row])
        }

        return cell
    }
  

}
