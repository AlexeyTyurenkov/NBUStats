//
//  TableManagerDelegateProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


protocol PresenterViewDelegate: class 
{
    func presenter(_: PresenterProtocol, updateAsProfessional: Bool)
    func presenter(_: PresenterProtocol, getError: Error)
    func presenterCancelSearch(_:PresenterProtocol)
    func presenterWillLoad(_: PresenterProtocol)
    func presenterDidLoad(_: PresenterProtocol)
}
