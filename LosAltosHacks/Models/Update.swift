//
//  Update.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import Foundation
import Alamofire

struct Update {
    let date: NSDate
    let description: String
    let tag: String
    
    /**
     Makes an asynchronous request to the LAH API to fetch the latest updates,
     and calls the callback on success.
     Recursively calls itself up to 3 times until is successful.
     */
    static func getUpdates(callback: [Update] -> Void) {
        getUpdates(recursiveDepth: 0, callback: callback)
    }
    
    /**
     Internal function which does the actual recursion.
     */
    private static func getUpdates(recursiveDepth recursiveDepth: Int, callback: [Update] -> Void) {
        
        guard recursiveDepth < 3 else { return }
        
        let url = LAHConstants.BaseAPIURLString + "updates.json"
        
        Alamofire.request(.GET, url).responseJSON { response in
            guard let rawUpdates = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments) else {
                // recurse
                getUpdates(recursiveDepth: recursiveDepth+1, callback: callback)
                return
            }
            
            let updates = (rawUpdates as! [[String:AnyObject]])
                .map {
                    Update(
                        date: NSDate(timeIntervalSince1970: NSTimeInterval($0["date"]!.intValue)),
                        description: $0["description"] as! String,
                        tag: $0["tag"] as! String
                    )
            }
            callback(updates)
        }
    }
}
