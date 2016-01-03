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
    
    static func getUpdates(callback: ([Update]) -> Void) /*-> [Update]*/ {
        
        // make a network request here

        let url = LAHConstants.BaseAPIURLString + "updates.json"
        Alamofire.request(.GET, url)
                 .responseJSON { response in
                    print(response)
                    let rawUpdates = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                    let updates = (rawUpdates as! [[String:AnyObject]])
                        .map {
                            Update(
                                date: NSDate(timeIntervalSince1970: NSTimeInterval($0["date"]!.intValue)),
                                description: $0["description"] as! String
                            )
                    }
                    callback(updates)
                 }
    }
}
