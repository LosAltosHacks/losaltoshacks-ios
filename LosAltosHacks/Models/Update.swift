//
//  Update.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation

struct Update {
    let time: Date
    let title: String
    let description: String
    let tag: Tag

    static var delegates = [CacheableDelegate]()
}

extension Update: Cacheable {
    static var cacheKey: String {
        return "updatesCache"
    }
}

extension Update: JSONConvertible {
    var asJSON: [String:Any] {
        return [
            "time": time.timeIntervalSince1970 as AnyObject,
            "title": title as AnyObject,
            "description": description as AnyObject,
            "tag": tag.rawValue as AnyObject
        ]
    }
    
    init?(json: Any) {
        guard
            let json = json as? [String:Any],
            let timeJ = json["time"] as? Int,
            let time = Optional(Date(timeIntervalSince1970: TimeInterval(timeJ))),
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let tagJ = json["tag"] as? String,
            let tag = Tag(rawValue: tagJ.lowercased())
        else { return nil }

        self = Update(
            time: time,
            title: title,
            description: description,
            tag: tag
        )
    }
}

extension Update: Sortable {
    static func sort(_ items: [Update]) -> [Update] {
        return items.sorted { !$0.time.isEarlierThanDate($1.time) }
    }
}
