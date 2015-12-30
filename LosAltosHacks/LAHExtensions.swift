//
//  LAHExtensions.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/30/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation

extension Double {
    var sAtEnd: String {
        if Int(self) == 1 {
            return ""
        }
        return "s"
    }
}

extension NSDate {

    enum Time {
        case Second(Double)
        case Minute(Double)
        case Hour(Double)
        case Day(Double)
        case Year(Double)
        
        var typeDescription: String {
            switch self {
            case .Second(let s): return "second\(s.sAtEnd)"
            case .Minute(let m): return "minute\(m.sAtEnd)"
            case .Hour(let h): return "hour\(h.sAtEnd)"
            case .Day(let d): return "day\(d.sAtEnd)"
            case .Year(let y): return "year\(y.sAtEnd)"
            }
        }
        
        var amount: Double {
            switch self {
            case .Second(let s): return s
            case .Minute(let m): return m
            case .Hour(let h): return h
            case .Day(let d): return d
            case .Year(let y): return y
            }
        }
    }
    
    
    /// ```
    /// <1-60/1-24/1-infinity> <minute(s)/hour(s)/day(s)> ago
    /// ```
    /// ex: 34 minutes ago
    ///
    /// ex: 1 hour ago
    ///
    /// ex: 98 days ago
    var LAHPreferredDisplay: String {
        
        let secondsSinceUpdate = -timeIntervalSinceNow
        
        let time: Time
        
        switch secondsSinceUpdate {
        case 0..<3600:
            time = .Minute(secondsSinceUpdate/60)
        case 3600..<86400:
            time = .Hour(secondsSinceUpdate/3600)
        default:
            time = .Day(secondsSinceUpdate/86400)
        }
        
        return "\(Int(time.amount)) \(time.typeDescription) ago"
    }
}
