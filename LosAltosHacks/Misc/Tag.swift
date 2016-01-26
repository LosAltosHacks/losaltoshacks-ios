//
//  Tag.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/21/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

enum Tag: String {
    case Food = "food"
    case Logistics = "logistics"
    case Activity = "activity"
    case Workshop = "workshop"
    case None = ""
    
    var color: LAHColor {
        switch self {
        case .Food: return .Food
        case .Logistics: return .Logistics
        case .Workshop: return .Workshop
        case .Activity: return .Activity
            
        case .None: return .Transparent
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue.lowercaseString)
    }
}
