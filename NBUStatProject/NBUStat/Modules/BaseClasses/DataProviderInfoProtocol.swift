//
//  DataProviderInfoProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/3/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


protocol DataProviderInfoProtocol
{
    var link: URL { get }
    var text: String { get }
    var title: String { get }
}
