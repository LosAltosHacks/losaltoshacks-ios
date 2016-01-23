//
//  Event.swift
//  LosAltosHacks
//
//  Created by Kyle Sandell on 1/7/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

struct Event {
    let start: NSDate
    let end: NSDate
    let title: String
    let description: String
    let location: String
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
            "start": start.timeIntervalSince1970,
            "end": end.timeIntervalSince1970,
            "title": title,
            "description": description,
            "location": location,
            "tag": tag.rawValue
        ]
        
        let jsonObject = try! NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
        
        return String(data: jsonObject, encoding: NSUTF8StringEncoding)!
    }
    
    static func parse(json: AnyObject) -> Event {
        let json = json as! [String:AnyObject]
        return Event(
            start: NSDate(timeIntervalSince1970: NSTimeInterval(json["start"]!.intValue)),
            end: NSDate(timeIntervalSince1970: NSTimeInterval(json["end"]!.intValue)),
            title: json["title"] as! String,
            description: json["description"] as! String,
            location: json["location"] as! String,
            tag: Tag(rawValue: (json["tag"] as! String).lowercaseString)!
        )
    }
}

extension Event: Sortable {
    static func sort(items: [Event]) -> [Event] {
         return items.sort { $0.start.isEarlierThanDate($1.start) }
    }
}

extension Event {
    var isOnSaturday: Bool {
        let afterStart = !self.start.isEarlierThanDate(LAHConstants.LAHStartDate)
        let beforeSunday = self.start.isEarlierThanDate(LAHConstants.Sunday)
        return afterStart && beforeSunday
    }
    
    var isOnSunday: Bool {
        let afterStartOfSunday = !self.start.isEarlierThanDate(LAHConstants.Sunday)
        let beforeEnd = self.start.isEarlierThanDate(LAHConstants.LAHEndDate)
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
