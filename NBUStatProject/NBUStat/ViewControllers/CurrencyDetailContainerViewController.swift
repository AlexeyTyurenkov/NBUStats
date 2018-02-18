//
//  CurrencyDetailContainerViewController.swift
//  NBUStat
//
//  Created by Aleksey Tyurenkov on 7/17/17.
//  Copyright © 2017 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class CurrencyDetailContainerViewController: UIViewController {

    
    var currency: String = ""
    @IBOutlet weak var activityHolder: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currency
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let container = segue.destination as? CurrencyDetailTableViewController
        {
            container.currency = currency
            container.delegate = self
        }
    }
 
    
    func showActivity()
    {
        activityHolder.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideActivity()
    {
        activityHolder.isHidden = true
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

}
