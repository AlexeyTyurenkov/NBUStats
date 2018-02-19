//
//  File.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol
{
    func viewController() -> UIViewController
    var moduleName: String {get}
}
