//
//  LAHExtensions.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/30/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func scaledToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

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
        
    static func specificDate(year year: Int, month: Int, day: Int, hour: Int) -> NSDate {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        gregorian?.timeZone = NSTimeZone(name: "PST")!
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
