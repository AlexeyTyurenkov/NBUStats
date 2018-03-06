//
//  UXCurrentIndexViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/5/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit

class UXCurrentIndexViewController: UIViewController, PresenterViewDelegate {
    func presenter(_: PresenterProtocol, updateAsProfessional: Bool) {
        
    }
    
    func presenter(_: PresenterProtocol, getError: Error) {
        
    }
    
    func presenterCancelSearch(_: PresenterProtocol) {
        
    }
    
    func presenterWillLoad(_: PresenterProtocol) {
        
    }
    
    func presenterDidLoad(_: PresenterProtocol) {
        
    }
    

    
    var presenter: PresenterProtocol!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
