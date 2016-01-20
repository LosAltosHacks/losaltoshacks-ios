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
    static var path: String {
        return "schedule.json"
    }
    
    static func parse(json: AnyObject) -> Event {
        let json = json as! [String:AnyObject]
        return Event(
            from: NSDate(timeIntervalSince1970: NSTimeInterval(json["from"]!.intValue)),
            to: NSDate(timeIntervalSince1970: NSTimeInterval(json["to"]!.intValue)),
            title: json["title"] as! String,
            detail: json["detail"] as! String,
            location: json["location"] as! String,
            tag: json["tag"] as! String
        )
//            .sort { e1, e2 in e1.from.timeIntervalSince1970 < e2.from.timeIntervalSince1970 }
    }
}

extension Event: Cacheable {
    static var cacheKey: String {
        return "eventsCache"
    }
    
    func toJSON() -> String {
        
        let dict: [String:AnyObject] = [
            "from": from.timeIntervalSince1970,
            "to": to.timeIntervalSince1970,
            "title": title,
            "detail": detail,
            "location": location,
            "tag": tag
        ]
        
        let jsonObject = try! NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
        
        return String(data: jsonObject, encoding: NSUTF8StringEncoding)!
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
