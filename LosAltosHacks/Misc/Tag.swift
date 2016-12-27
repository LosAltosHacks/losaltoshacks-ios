//
//  Tag.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/21/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

enum Tag: String {
    case food = "food"
    case logistics = "logistics"
    case activity = "activity"
    case workshop = "workshop"
    case none = ""
    
    var color: LAHColor {
        switch self {
        case .food: return .food
        case .logistics: return .logistics
        case .workshop: return .workshop
        case .activity: return .activity
            
        case .none: return .transparent
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue.lowercased())
    }
}
