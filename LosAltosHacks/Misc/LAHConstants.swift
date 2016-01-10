//
//  LAHConstants.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/8/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

struct LAHConstants {
    
    static let LAHStartDate = NSDate.specificDate(1, day: 30, year: 2016, hour: 12)
    static let LAHEndDate = NSDate.specificDate(1, day: 31, year: 2016, hour: 12)
    
    static let BaseAPIURLString = "http://www.losaltoshacks.com/api/"
    
    enum Color {
        case DefaultColor
        case DefaultGreyColor
        case DefaultDarkGreyColor
        
        case Logistics
        case Food
        case Workshop
        
        var value: UIColor {
            
            let c: UIColor
            switch self {
                
            case .DefaultColor:
                c = UIColor(red: 126.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            case .DefaultGreyColor:
                c = UIColor(white: 0.6, alpha: 1.0)
            case .DefaultDarkGreyColor:
                c = UIColor(white: 0.3, alpha: 1.0)
                
            case .Logistics:
                c = UIColor(red: 165/255, green: 188/255, blue: 62/255, alpha: 1.0)
            case .Food:
                c = UIColor(red: 245/255, green: 124/255, blue: 125/255, alpha: 1.0)
            case .Workshop:
                c = UIColor(red: 10/255, green: 96/255, blue: 201/255, alpha: 1.0)
                
            }
            
            return c
        }
        
        init?(from: String) {
            switch from {
            case "Logistics": self = .Logistics
            case "Food": self = .Food
            case "Workshop": self = .Workshop
            default: return nil
            }
        }
    }
}
