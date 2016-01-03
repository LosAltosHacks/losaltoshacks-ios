//
//  LAHExtensions.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/30/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation
import UIKit

struct LAHConstants {
    static let defaultColor = UIColor(red: 126.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let defaultGreyColor = UIColor(white: 0.6, alpha: 1.0)
    static let defaultDarkGreyColor = UIColor(white: 0.3, alpha: 1.0)

    static let LAHStartDate = NSDate.specificDate(1, day: 1, year: 2016, hour: 17)
    static let LAHEndDate = NSDate.specificDate(1, day: 3, year: 2016, hour: 17)
}

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

    static func specificDate(month: Int, day: Int, year: Int, hour: Int) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.month = month
        components.day = day
        components.year = year
        components.hour = hour
        return gregorian!.dateFromComponents(components)!
    }

    func isEarlierThanDate(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedAscending)
    }
}

extension NSTimeInterval {
    var hours: Int {
        return Int(self) / 3600
//        return hours < 10 ? "0\(hours)" : "\(hours)"
    }
    var minutes: Int {
        return Int(self / 60) % 60
//        return minutes < 10 ? "0\(minutes)" : "\(minutes)"
    }
    var seconds: Int  {
//        return "\(Int(self % 60))"
        return Int(self) % 60
//        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
}
