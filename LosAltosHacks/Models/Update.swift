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
    
    static func getUpdates() -> [Update] {
        
        // make a network request here
        
        let testJSON = [
            "[{",
            "\"description\": \"Doors open!!!!\",",
            "\"date\": 1451490300",
            "}]"
            ].joinWithSeparator("\n")
        
        let data = testJSON.dataUsingEncoding(NSUTF8StringEncoding)!
        
        let rawUpdates = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
        let updates = (rawUpdates as! [[String:AnyObject]])
            .map {
                Update(
                    date: NSDate(timeIntervalSince1970: NSTimeInterval($0["date"] as! Int)),
                    description: $0["description"] as! String
                )
        }
        
        return updates
    }
}
