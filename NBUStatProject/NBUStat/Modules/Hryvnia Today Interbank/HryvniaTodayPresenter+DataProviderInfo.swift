//
//  HryvniaTodayPresenter+DataProviderInfo.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/3/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation


extension HryvniaTodayPresenter: DataProviderInfoProtocol
{
    var link: URL {
        return URL(string: "http://Hryvna.today")!
    }
    
    var text: String {
        return "Дані отримано з сайту Hryvna.today \n" + 
        "Гривня Тудей – невеликий волонтерський проект, що має за мету детально розповісти про актуальний курс гривні, використовуючи просту і зрозумілу інфографіку."
    }
    
    var title: String {
        return "Сайт Hryvna.today"
    }
}
