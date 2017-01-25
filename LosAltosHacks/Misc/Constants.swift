//
//  Constants.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/8/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

extension String {
    static let slackURLString = "https://slack.losaltoshacks.com/"
}

extension Date {
    static let startDate = Date(year: 2017, month: 2, day: 4, hour: 9)
    static let endDate = Date(year: 2017, month: 2, day: 5, hour: 16)
    static let saturday = Date(year: 2017, month: 2, day: 4, hour: 0)
    static let sunday = Date(year: 2017, month: 2, day: 5, hour: 0)
}

extension UIColor {
    static let defaultColor = UIColor(red: 126.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let defaultGreyColor = UIColor(white: 0.6, alpha: 1.0)
    static let defaultDarkGreyColor = UIColor(white: 0.3, alpha: 1.0)
    static let transparent = UIColor(white: 0, alpha: 0)
    static let logistics = UIColor(red: 244/255, green: 208/255, blue: 63/255, alpha: 1.0)
    static let food = UIColor(red: 246/255, green: 71/255, blue: 71/255, alpha: 1.0)
    static let workshop = UIColor(red: 65/255, green: 131/255, blue: 215/255, alpha: 1.0)
    static let activity = UIColor(red: 236/255, green: 120/255, blue: 240/255, alpha: 1.0)
}
