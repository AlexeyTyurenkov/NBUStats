//
//  PresenterProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/20/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterProtocol: class {
    var delegate: PresenterViewDelegate? { get set }
    func updateView()
    func viewLoaded()
    var cellTypes: [BaseTableCellProtocol.Type] { get }
}

protocol DateDependedPresenterProtocol:PresenterProtocol
{
    var date: Date { get set }
    var picker: UIDatePicker {get}
    var dateFormatter: DateFormatter{ get }
    var nextDate:String {get}
    var prevDate:String {get}
    var currentDate: String {get}
    func moveNextDate()
    func movePreviousDate()
}


