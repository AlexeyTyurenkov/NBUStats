//
//  PFTSIndexModel.swift
//  FinstatLib
//
//  Created by Aleksey Tyurenkov on 3/10/18.
//  Copyright © 2018 Oleksii Tiurenkov. All rights reserved.
//

import Foundation

public struct PFTSIndexModel
{
    /*{"id":1,"current":"351,7497","max52":"351,9289","min52":"268,6970","previous":"351,9289","change":"%-0,0509","moment":"07.03.2018","created_at":"2018-03-09 21:17:19","updated_at":"2018-03-09 21:17:19"}*/
    
    public var moment: String
    public var current: String
    public var max52: String
    public var min52: String
    public var previous: String
    public var change: String
    public var updated: String

    
    public init(dictionary: [String:Any])
    {
        updated = (dictionary["updated_at"] as? String) ?? ""
        moment = (dictionary["moment"] as? String) ?? ""
        current = (dictionary["current"] as? String) ?? ""
        min52 = (dictionary["min52"] as? String) ?? ""
        max52 = (dictionary["max52"] as? String) ?? ""
        previous = (dictionary["previous"] as? String) ?? ""
        change = (dictionary["change"] as? String) ?? ""
    }
}
