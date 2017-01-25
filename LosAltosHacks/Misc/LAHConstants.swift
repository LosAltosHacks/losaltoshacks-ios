//
//  LAHConstants.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/8/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

struct LAHConstants {
    static let LAHStartDate = Date.specificDate(year: 2016, month: 1, day: 30, hour: 9)
    static let LAHEndDate = Date.specificDate(year: 2016, month: 1, day: 31, hour: 16)
    static let Saturday = Date.specificDate(year: 2016, month: 1, day: 30, hour: 0)
    static let Sunday = Date.specificDate(year: 2016, month: 1, day: 31, hour: 0)

    static let SlackURLString = "https://slack.losaltoshacks.com/"
}

enum LAHColor {
    case defaultColor
    case defaultGreyColor
    case defaultDarkGreyColor
    case transparent
    
    case logistics
    case food
    case workshop
    case activity
    
    var value: UIColor {
        
        let c: UIColor
        switch self {
        case .defaultColor:
            c = UIColor(red: 126.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .defaultGreyColor:
            c = UIColor(white: 0.6, alpha: 1.0)
        case .defaultDarkGreyColor:
            c = UIColor(white: 0.3, alpha: 1.0)
        case .transparent:
            c = UIColor(white: 0, alpha: 0)
        case .logistics:
            c = UIColor(red: 244/255, green: 208/255, blue: 63/255, alpha: 1.0)
        case .food:
            c = UIColor(red: 246/255, green: 71/255, blue: 71/255, alpha: 1.0)
        case .workshop:
            c = UIColor(red: 65/255, green: 131/255, blue: 215/255, alpha: 1.0)
        case .activity:
            c = UIColor(red: 236/255, green: 120/255, blue: 240/255, alpha: 1.0)
        }
        
        return c
    }
}
