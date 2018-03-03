//
//  DataProviderInfoViewController.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/3/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import UIKit
import SafariServices

class DataProviderInfoViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var openLinkButton: UIButton!
    
    var info: DataProviderInfoProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = info.title
        mainTextLabel.text = info.text
        openLinkButton.setTitle("Відкрити сайт", for: .normal)
        openLinkButton.setTitle("Відкрити сайт", for: .selected)
        openLinkButton.setTitle("Відкрити сайт", for: .highlighted)
        openLinkButton.setTitle("Відкрити сайт", for: .disabled)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func openLink(_ sender: Any) {
        let safari = SFSafariViewController(url: info.link)
        safari.delegate = self
        self.present(safari, animated: true, completion: nil)
    }
}

extension DataProviderInfoViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
    }
}
