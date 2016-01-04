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
    static let LAHEndDate = NSDate.specificDate(1, day: 3, year: 2016, hour: 0)

    static let BaseAPIURLString = "http://www.losaltoshacks.com/api/"

    static let LAHFunnyColors = [
        UIColor(red: 62/255, green: 209/255, blue: 140/255, alpha: 1.0),
        UIColor(red: 245/255, green: 124/255, blue: 125/255, alpha: 1.0),
        UIColor(red: 10/255, green: 96/255, blue: 201/255, alpha: 1.0),
        UIColor(red: 122/255, green: 208/255, blue: 254/255, alpha: 1.0),

    ]
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
        
    static func specificDate(month: Int, day: Int, year: Int, hour: Int) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.month = month
        components.day = day
        components.year = year
        components.hour = hour
        return gregorian!.dateFromComponents(components)!
    }

    // TODO: move this to a `<` overload
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
