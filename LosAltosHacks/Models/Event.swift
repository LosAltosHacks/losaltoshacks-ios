//
//  Event.swift
//  LosAltosHacks
//
//  Created by Kyle Sandell on 1/7/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

struct Event {
    let event: String
    let location: String
    let time: NSDate
    let tag: Tag

    static var delegates = [CacheableDelegate]()
}

extension Event: Fetchable {
    static var path: String {
        return "schedule.json"
    }
}

extension Event: Cacheable {
    static var cacheKey: String {
        return "eventsCache"
    }
}

extension Event: JSONConvertible {
    func toJSON() -> String {
        
        let dict: [String:AnyObject] = [
            "event": event,
            "time": time.timeIntervalSince1970,
            "location": location,
            "tag": tag.rawValue
        ]
        
        let jsonObject = try! NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
        
        return String(data: jsonObject, encoding: NSUTF8StringEncoding)!
    }
    
    static func parse(json: AnyObject) -> Event {
        let json = json as! [String:AnyObject]
        return Event(
            event: json["event"] as! String,
            location: json["location"] as! String,
            time: NSDate(timeIntervalSince1970: NSTimeInterval(json["time"]!.intValue)),
            tag: Tag(rawValue: (json["tag"] as! String).lowercaseString)!
        )
    }
}

extension Event: Sortable {
    static func sort(items: [Event]) -> [Event] {
         return items.sort { $0.time.isEarlierThanDate($1.time) }
    }
}

extension Event {
    var isOnSaturday: Bool {
        let afterStart = !self.time.isEarlierThanDate(LAHConstants.LAHStartDate)
        let beforeSunday = self.time.isEarlierThanDate(LAHConstants.Sunday)
        return afterStart && beforeSunday
    }
    
    var isOnSunday: Bool {
        let afterStartOfSunday = !self.time.isEarlierThanDate(LAHConstants.Sunday)
        let beforeEnd = self.time.isEarlierThanDate(LAHConstants.LAHEndDate)
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
