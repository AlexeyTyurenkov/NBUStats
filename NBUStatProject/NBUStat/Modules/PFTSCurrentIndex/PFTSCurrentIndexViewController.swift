//
//  UXCurrentIndexViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/5/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class PFTSCurrentIndexViewController: BaseViewController, PresenterViewDelegate {
    
    
    func presenter(_ presenter: PresenterProtocol, updateAsProfessional: Bool) {
        if let presenter = presenter as? PFTSCurrentIndexPresenter,
            let model = presenter.currentModel
        {
            moment.text = model.moment
            maxValue.text = model.max52
            currentIndex.text = model.current
            openingIndex.text = model.previous
            minValue.text = model.min52
            change.text = model.change
            view.sendSubview(toBack: activityView)
            activityView.isHidden = true
        }
    }
    
    func presenter(_: PresenterProtocol, getError: Error) {
        
    }
    
    func presenterCancelSearch(_: PresenterProtocol) {
        
    }
    
    func presenterWillLoad(_: PresenterProtocol) {
        
    }
    
    func presenterDidLoad(_: PresenterProtocol) {
        
    }
    

    
    var presenter: PFTSCurrentIndexPresenterProtocol!
    @IBOutlet weak var activityView: UIView!
    weak var refreshController:RefreshController?
    
    @IBOutlet weak var moment: UILabel!
    @IBOutlet weak var currentIndex: UILabel!
    @IBOutlet weak var openingIndex: UILabel!
    @IBOutlet weak var minValue: UILabel!
    @IBOutlet weak var maxValue: UILabel!
    @IBOutlet weak var change: UILabel!
    
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
    
    @IBAction func providerButtonPressed(_ sender: UIBarButtonItem) {
        presenter.showDataProviderInfo()
    }
    

}
