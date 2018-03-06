//
//  DataProviderPresentingProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/7/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

protocol DataProviderPresentationProtocol
{
    func presentDataProviderInfo(from: UIViewController, dataProviderInfo: DataProviderInfoProtocol)
}

extension DataProviderPresentationProtocol
{
    func presentDataProviderInfo(from view: UIViewController, dataProviderInfo: DataProviderInfoProtocol)
    {
        let storyBoard = UIStoryboard(name: "DataProviderCredits", bundle: nil)
        if let controller = storyBoard.instantiateInitialViewController() as? DataProviderInfoViewController
        {
            controller.info = dataProviderInfo
            view.show(controller, sender: self)
        }
    }
}
