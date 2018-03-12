//
//  PrivateCurrencyRatesPresenter+DataProviderInfo.swift
//  FinStat Ukraine
//
//  Created by Aleksey Tyurenkov on 3/11/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

extension PrivateCurrencyRatesPresenter: DataProviderInfoProtocol
{
    var link: URL {
        return URL(string:"https://privatbank.ua/")!
    }
    
    var text: String {
        return "ПриватБанк є одним з найбільш інноваційних банків світу. Наприклад, понад десять років назад банк став одним із перших у світі, що почав використовувати одноразові SMS-паролі. До останніх інновацій, які отримали визнання по всьому світі, належать такі продукти, як платіжний міні-термінал, вхід в Інтернет-банкінг через QR-код, онлайн-інкасація, а також десятки різноманітних мобільных додатків."
    }
    
    var title: String {
        return "ПАТ КБ «ПРИВАТБАНК»"
    }
    
    
}
