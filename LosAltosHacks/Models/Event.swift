//
//  Event.swift
//  LosAltosHacks
//
//  Created by Kyle Sandell on 1/7/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation
import Alamofire

struct Event {
    let from: NSDate
    let description: String
    let to: NSDate
    let location: String

}

extension Event: Fetchable {
    static func path() -> String {
        return "schedule.json"
    }
    
    static func parse(json: AnyObject) -> [Event] {
        return (json as! [[String:AnyObject]])
            .map {
                Event(
                    from: NSDate(timeIntervalSince1970: NSTimeInterval($0["start"]!.intValue)),
                    description: $0["event"] as! String,
                    to: NSDate(timeIntervalSince1970: NSTimeInterval($0["end"]!.intValue)),
                    location: $0["location"] as! String
                )
            }
    }
}
