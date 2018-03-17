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


class PrivateCurrencyViewController: BaseViewController,PrivateCurrencyRatesViewInput, PresenterViewDelegate {
    
    private var privateController: PrivateInternalTableViewController?
    
    func presenter(_ presenter: PresenterProtocol, updateAsProfessional: Bool) {
        if let privateController = privateController
        {
            configure(privateController: privateController)
        }
       view.sendSubview(toBack: activityView)
        activityView.isHidden = true
    }
    
    func presenter(_: PresenterProtocol, getError: Error) {
        
    }
    
    func presenterCancelSearch(_: PresenterProtocol) {
        
    }
    
    func presenterWillLoad(_: PresenterProtocol) {
        activityView.isHidden = false
        refreshController?.animation{ return !self.activityView.isHidden }
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
        let refresh = RefreshController.defaultRefresh(frame: activityView.bounds)
        refreshController = refresh
        activityView.addSubview(refresh)
        presenter.viewLoaded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dataproviderTapped(_ sender: Any) {
        presenter.showDataProviderInfo()

    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        presenter.load(index: sender.selectedSegmentIndex)
    }
    
    override func configure(privateController: PrivateInternalTableViewController) {
        self.privateController = privateController
        self.privateController?.configure(with: presenter)
        self.privateController?.tableView.reloadData()
    }

}
