//
//  LAHPreferredDisplay.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/4/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

extension Date {
    /// ```
    /// <1-60/1-24/1-infinity> <minute(s)/hour(s)/day(s)>
    /// ```
    /// ex: 34 minutes ago
    ///
    /// ex: 1 hour ago
    ///
    /// ex: 98 days ago
    ///
    /// ex: in 10 days
    var displayDescription: String {
        let seconds = -timeIntervalSinceNow
        
        let time: Date.Time
        
        switch seconds {
        case 0..<60:
            return "Just now"
        case 60..<3600:
            time = .minute(seconds/60)
        case 3600..<86400:
            time = .hour(seconds/3600)
        default:
            time = .day(seconds/86400)
        }
        
        if seconds < 0 {
            return "in \(-Int(time.amount)) \(time.typeDescription)"
        } else {
            return "\(Int(time.amount)) \(time.typeDescription) ago"
        }
    }
}
