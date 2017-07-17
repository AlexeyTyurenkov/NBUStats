//
//  CurrencyDetailTableViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/17/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import Alamofire


class CurrencyDetailTableViewController: UITableViewController {

    
    var currency: String = ""
    let dateFormatter = DateFormatter()
    private var rates: [CurrencyRate] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = currency
        
        dateFormatter.dateFormat = "yyyyMMdd"
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            let dispatchGroup = DispatchGroup()
            let calendar = NSCalendar.current
            let startDate = Date() // first date
            //let endDate = Date() // last date
            var downloadedRates:[CurrencyRate] = []

            for i in 1...30
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
                        
                    default: break;
                    }
                    dispatchGroup.leave()
                }
               
            }
            dispatchGroup.wait()
            DispatchQueue.main.async {
                self?.rates = downloadedRates.sorted(by: { (lhs, rhs) -> Bool in
                    return lhs.exchangedate < rhs.exchangedate
                })
                strongSelf.tableView.reloadData()
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
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
