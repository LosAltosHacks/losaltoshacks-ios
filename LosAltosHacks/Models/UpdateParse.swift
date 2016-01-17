//
//  UpdateParse.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/16/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit
import Parse

enum SortKey {
    case Newest
    case Oldest
}

class UpdateParse : PFObject, PFSubclassing {
    @NSManaged var content: String
    @NSManaged var tag: String

    static func fetch(callback: PFQueryArrayResultBlock) {
        let query = PFQuery(className: "Update")
        query.findObjectsInBackgroundWithBlock(callback)
    }

    static func fetch(limit: Int, sorted: SortKey, callback: PFQueryArrayResultBlock) {
        UpdateParse.fetch { results, error in
            if error != nil {
                print(error)
            } else if let results = results {
                let guardLimit = limit < results.count && limit > 0 ? limit : results.count
                if sorted == .Newest {
                    callback(Array(results.suffix(guardLimit)), error)
                } else {
                    callback(Array(results.prefix(guardLimit)), error)
                }
            }
        }
    }

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
        return "Update"
    }
}