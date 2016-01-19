//
//  EventParse.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/16/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit
import Parse

class EventParse : PFObject, PFSubclassing {
    @NSManaged var from: NSDate
    @NSManaged var to: NSDate
    @NSManaged var title: String
    @NSManaged var detail: String
    @NSManaged var location: String
    @NSManaged var tag: String

    static func fetch(callback: PFQueryArrayResultBlock) {
        let query = PFQuery(className: "Event")
        query.addAscendingOrder("from")
        query.findObjectsInBackgroundWithBlock(callback)
    }

//    static func fetch(limit: Int, sortBy sorted: SortKey, callback: PFQueryArrayResultBlock) {
//        UpdateParse.fetch(sortBy: sorted) { results, error in
//            if error != nil {
//                print(error)
//            } else if let results = results {
//                let guardLimit = limit < results.count && limit > 0 ? limit : results.count
//                callback(Array(results.prefix(guardLimit)), error)
//            }
//        }
//    }

    // MARK: PFSubclassing

    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }

    class func parseClassName() -> String {
        return "Event"
    }
}