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
    
    /**
     Makes an asynchronous request to the LAH API to fetch the latest updates,
     and calls the callback on success.
     Recursively calls itself up to 3 times until is successful.
     */
    static func getEvents(callback: [Event] -> Void) {
        getEvents(recursiveDepth: 0, callback: callback)
    }
    
    /**
     Internal function which does the actual recursion.
     */
    private static func getEvents(recursiveDepth recursiveDepth: Int, callback: [Event] -> Void) {
        
        guard recursiveDepth < 3 else { return }
        
        let url = LAHConstants.BaseAPIURLString + "schedule.json"
        
        Alamofire.request(.GET, url).responseJSON { response in
            guard let rawUpdates = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments) else {
                // recurse
                getEvents(recursiveDepth: recursiveDepth+1, callback: callback)
                return
            }
            
            let updates = (rawUpdates as! [[String:AnyObject]])
                .map {
                    Event(
                        from: NSDate(timeIntervalSince1970: NSTimeInterval($0["start"]!.intValue)),
                        description: $0["event"] as! String,
                        to: NSDate(timeIntervalSince1970: NSTimeInterval($0["end"]!.intValue)),
                        location: $0["location"] as! String
                    )
            }
            callback(updates)
        }
    }
}
