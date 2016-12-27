//
//  Update.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation

struct Update {
    let date: Date
    let title: String
    let description: String
    let tag: Tag
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
            "date": date.timeIntervalSince1970 as AnyObject,
            "title": title as AnyObject,
            "description": description as AnyObject,
            "tag": tag.rawValue as AnyObject
        ]
        
        let jsonObject = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        return String(data: jsonObject, encoding: String.Encoding.utf8)!
    }
    
    static func parse(_ json: Any) -> Update {
        let json = json as! [String:Any]
        
        return Update(
            date: Date(timeIntervalSince1970: TimeInterval((json["date"]! as AnyObject).int32Value)),
            title: json["title"] as! String,
            description: json["description"] as! String,
            tag: Tag(rawValue: (json["tag"] as! String).lowercased())!
        )
    }
}

extension Update: Sortable {
    static func sort(_ items: [Update]) -> [Update] {
        return items.sorted { !$0.date.isEarlierThanDate($1.date) }
    }
}
