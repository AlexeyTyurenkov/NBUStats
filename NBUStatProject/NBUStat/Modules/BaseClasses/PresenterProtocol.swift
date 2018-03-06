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
    weak var delegate: PresenterViewDelegate? { get set }
    func updateView()
    func viewLoaded()
    var cellTypes: [BaseTableCellProtocol.Type] { get }
    var dataProviderInfo: DataProviderInfoProtocol { get }
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
    func nextDate(for date: Date) -> Date
    func prevDate(for date: Date) -> Date

}

extension DateDependedPresenterProtocol
{
    var currentDate: String
    {
        return dateFormatter.string(from: date)
    }
    var nextDate:String {
        return dateFormatter.string(from: nextDate(for: date))
    }
    var prevDate:String {
        return dateFormatter.string(from: prevDate(for: date))
    }
    
    func moveNextDate()
    {
        date = nextDate(for: date)
    }
    func movePreviousDate()
    {
        date = prevDate(for: date)
    }
}
