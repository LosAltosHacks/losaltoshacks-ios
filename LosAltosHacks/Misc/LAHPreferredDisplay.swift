//
//  LAHPreferredDisplay.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/4/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

struct LAHPreferredDisplay {
    
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
    static func from(date: NSDate) -> String {
        
        let seconds = -date.timeIntervalSinceNow
        
        let time: NSDate.Time
        
        switch seconds {
        case 0..<60:
            return "Just now"
        case 60..<3600:
            time = .Minute(seconds/60)
        case 3600..<86400:
            time = .Hour(seconds/3600)
        default:
            time = .Day(seconds/86400)
        }
        
        if seconds < 0 {
            return "in \(-Int(time.amount)) \(time.typeDescription)"
        } else {
            return "\(Int(time.amount)) \(time.typeDescription) ago"
        }
    }
    
    static func range(dateFrom: NSDate, dateTo: NSDate) -> String {
        
        return "From \(dateFrom) to \(dateTo)"
    }
}
