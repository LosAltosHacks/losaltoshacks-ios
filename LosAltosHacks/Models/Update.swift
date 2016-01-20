//
//  Update.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation

struct Update {
    let date: NSDate
    let description: String
    let tag: String
}

extension Update: Fetchable {
    static var path: String {
        return "updates.json"
    }
}

extension Update: Cacheable {
    static var cacheKey: String {
        return "updatesCache"
    }
}

extension Update: JSONConvertible {
    func toJSON() -> String {
        
        let dict: [String:AnyObject] = [
            "date": date.timeIntervalSince1970,
            "description": description,
            "tag": tag
        ]
        
        let jsonObject = try! NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
        
        return String(data: jsonObject, encoding: NSUTF8StringEncoding)!
    }
    
    static func parse(json: AnyObject) -> Update {
        let json = json as! [String:AnyObject]
        
        return Update(
            date: NSDate(timeIntervalSince1970: NSTimeInterval(json["date"]!.intValue)),
            description: json["description"] as! String,
            tag: json["tag"] as! String
        )
    }
}

extension Update: Sortable {
    static func sort(items: [Update]) -> [Update] {
        return items.sort { !$0.date.isEarlierThanDate($1.date) }
    }
}
