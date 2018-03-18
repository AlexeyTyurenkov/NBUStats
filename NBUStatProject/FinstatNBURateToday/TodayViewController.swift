//
//  TodayViewController.swift
//  FinstatNBURateToday
//
//  Created by Aleksey Tyurenkov on 3/18/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import NotificationCenter
import FinstatLib


class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var usdValue: UILabel!
    @IBOutlet weak var eurValue: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    
    private var service = NBURatesService()
    override func viewDidLoad() {
        super.viewDidLoad()
        usdValue.text = "---"
        eurValue.text = "---"
        // Do any additional setup after loading the view from its nib.

    }
    
    func update(label: UILabel, rate: [CurrencyRate])
    {
        guard rate.count == 1 else { return }
        guard let rate = rate.first else { return }
        label.text = rate.newRate.stringValue
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMainApplicationTapped(_ sender: Any) {
        guard let mainApplicationURL = URL(string: "finstatukraine://nbu") else { return }
        self.extensionContext?.open(mainApplicationURL, completionHandler: nil)
    }
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: Date())
        service.loadList(param: dateString) { (rates, error) in
            if error == nil
            {
                let rates = rates.filter{ return ($0.r030 == "840" || $0.r030 == "978") }
                self.update(label: self.usdValue, rate: rates.filter{ $0.r030 == "840"});
                self.update(label: self.eurValue, rate: rates.filter{ $0.r030 == "978"});
                completionHandler(NCUpdateResult.newData)
            }
            else
            {
                completionHandler(NCUpdateResult.failed)
            }
        }

    }
    
}
