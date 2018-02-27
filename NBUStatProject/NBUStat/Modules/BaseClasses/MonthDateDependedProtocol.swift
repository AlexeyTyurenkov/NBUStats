//
//  MonthDateDependedProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/27/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

protocol MonthDateDependedProtocol: DateDependedPresenterProtocol {
    
}


extension MonthDateDependedProtocol
{
    var picker: UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.date = self.date
        picker.minimumDate = Date(timeIntervalSince1970: 946727869)
        picker.sizeToFit()
        return picker
    }
    
    func nextDate(for date: Date) -> Date
    {
        return Calendar.current.date(byAdding: .month, value: 1, to: date)!//date.addingTimeInterval(1*24*60*60)
    }
    
    func prevDate(for date: Date) -> Date
    {
        return Calendar.current.date(byAdding: .month, value: -1, to: date)!
    }
    
    var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        return dateFormatter
    }
    

}
