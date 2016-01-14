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
    static func path() -> String {
        return "updates.json"
    }
    
    static func parse(json: AnyObject) -> [Update] {
        return (json as! [[String:AnyObject]])
            .map {
                Update(
                    date: NSDate(timeIntervalSince1970: NSTimeInterval($0["date"]!.intValue)),
                    description: $0["description"] as! String,
                    tag: $0["tag"] as! String
                )
            }
    }
}
