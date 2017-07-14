//
//  CurrencyViewController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/14/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    weak var presenter: CurrencyRateTableViewController?
    var date = Date()
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeDateButtonPressed(_ sender: Any) {
        date = date.addingTimeInterval(-1*24*60*60)
        presenter?.setDate(date: date)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        presenter = segue.destination as? CurrencyRateTableViewController
        presenter?.setDate(date: date)
        
    }
 

}
