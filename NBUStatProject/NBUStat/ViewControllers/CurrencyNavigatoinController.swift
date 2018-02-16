//
//  CurrencyNavigatoinController.swift
//  NBUStat
//
//  Created by Oleksii Tiurenkov on 7/17/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyNavigatoinController: UINavigationController {

    
    weak var currencySource: CurrencyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let destination = viewControllers.first as? CurrencyViewController
        {
            currencySource = destination
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let detail = segue.destination as? CurrencyDetailContainerViewController
        {
            detail.currency = currencySource?.detailedCurrency ?? ""
        }

    }

    
    
}
