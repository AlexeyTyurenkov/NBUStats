//
//  DatePickerProviderProtocol.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 2/26/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation
import UIKit

protocol DayDateDependedProtocol: DateDependedPresenterProtocol {
    
}


extension DayDateDependedProtocol
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
        return date.addingTimeInterval(1*24*60*60)
    }
    
    func prevDate(for date: Date) -> Date
    {
        return date.addingTimeInterval(-1*24*60*60)
    }
    
    var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }
    
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
