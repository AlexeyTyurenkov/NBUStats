//
//  RatesServiceProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

public protocol RatesServiceProtocol {
    associatedtype Result
    func loadList(param: String, completion:  @escaping (([Result], Error?)->()))
}
