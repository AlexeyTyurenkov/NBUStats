//
//  PrivateCurrencyViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/11/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

protocol PrivateCurrencyRatesViewInput: class
{
    
}


class PrivateCurrencyViewController: UIViewController,PrivateCurrencyRatesViewInput, PresenterViewDelegate {
    
    func presenter(_: PresenterProtocol, updateAsProfessional: Bool) {
        activityView.isHidden = true
    }
    
    func presenter(_: PresenterProtocol, getError: Error) {
        
    }
    
    func presenterCancelSearch(_: PresenterProtocol) {
        
    }
    
    func presenterWillLoad(_: PresenterProtocol) {
        
    }
    
    func presenterDidLoad(_: PresenterProtocol) {
        
    }
    
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var containerView: UIView!
    weak var output: PrivateCurrencyRatesViewOutput?
    var presenter: PrivateCurrencyRatesPresenter!
    @IBOutlet weak var segmentController: UISegmentedControl!
    weak var refreshController:RefreshController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.isHidden = false
        let refresh = RefreshController.defaultRefresh(frame: activityView.bounds)
        refreshController = refresh
        activityView.addSubview(refresh)
        refreshController?.animation{ return !self.activityView.isHidden }
        presenter.viewLoaded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dataproviderTapped(_ sender: Any) {
        presenter.showDataProviderInfo()

    }
    

}
