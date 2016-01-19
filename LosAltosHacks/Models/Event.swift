//
//  Event.swift
//  LosAltosHacks
//
//  Created by Kyle Sandell on 1/7/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

struct Event {
    let from: NSDate
    let to: NSDate
    let title: String
    let detail: String
    let location: String
    let tag: String
}

extension Event: Fetchable {
    static func path() -> String {
        return "schedule.json"
    }
    
    static func parse(json: AnyObject) -> [Event] {
        return (json as! [[String:AnyObject]])
            .map {
                Event(
                    from: NSDate(timeIntervalSince1970: NSTimeInterval($0["from"]!.intValue)),
                    to: NSDate(timeIntervalSince1970: NSTimeInterval($0["to"]!.intValue)),
                    title: $0["title"] as! String,
                    detail: $0["detail"] as! String,
                    location: $0["location"] as! String,
                    tag: $0["tag"] as! String
                )
            }
            .sort { e1, e2 in e1.from.timeIntervalSince1970 < e2.from.timeIntervalSince1970 }
    }
}

extension Event {
    var isOnSaturday: Bool {
        let afterStart = !self.from.isEarlierThanDate(LAHConstants.LAHStartDate)
        let beforeSunday = self.from.isEarlierThanDate(LAHConstants.Sunday)
        return afterStart && beforeSunday
    }
    
    var isOnSunday: Bool {
        let afterStartOfSunday = !self.from.isEarlierThanDate(LAHConstants.Sunday)
        let beforeEnd = self.from.isEarlierThanDate(LAHConstants.LAHEndDate)
        return afterStartOfSunday && beforeEnd
    }
}

extension SequenceType where Generator.Element == Event {
    var onSaturday: [Event] {
        return self.filter { $0.isOnSaturday }
    }
    
    var onSunday: [Event] {
        return self.filter { $0.isOnSunday }
    }
}
