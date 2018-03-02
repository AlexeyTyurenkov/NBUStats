//
//  YearDependentProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/1/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit
import NTMonthYearPicker


protocol YearDependentProtocol: DateDependedPresenterProtocol {
    
}


extension YearDependentProtocol
{
    var picker: UIDatePicker {
        let picker = NTMonthYearPicker()
        picker.datePickerMode = NTMonthYearPickerMode.init(rawValue: 1)
        picker.maximumDate = Date()
        picker.date = self.date
        picker.minimumDate = Date(timeIntervalSince1970: 946727869)
        picker.sizeToFit()
        return (picker as? UIDatePicker) ?? UIDatePicker()
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
