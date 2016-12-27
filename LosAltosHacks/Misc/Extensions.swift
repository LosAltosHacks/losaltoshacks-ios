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

    func scaledToSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
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

extension Date {

    enum Time {
        case second(Double)
        case minute(Double)
        case hour(Double)
        case day(Double)
        case year(Double)
        
        var typeDescription: String {
            switch self {
            case .second(let s): return "second\(s.sAtEnd)"
            case .minute(let m): return "minute\(m.sAtEnd)"
            case .hour(let h): return "hour\(h.sAtEnd)"
            case .day(let d): return "day\(d.sAtEnd)"
            case .year(let y): return "year\(y.sAtEnd)"
            }
        }
        
        var amount: Double {
            switch self {
            case .second(let s): return s
            case .minute(let m): return m
            case .hour(let h): return h
            case .day(let d): return d
            case .year(let y): return y
            }
        }
    }
        
    static func specificDate(year: Int, month: Int, day: Int, hour: Int) -> Date {
        var gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        gregorian.timeZone = TimeZone(identifier: "PST")!
        var components = DateComponents()
        components.month = month
        components.day = day
        components.year = year
        components.hour = hour
        return gregorian.date(from: components)!
    }

    func isEarlierThanDate(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }
}

extension TimeInterval {
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
