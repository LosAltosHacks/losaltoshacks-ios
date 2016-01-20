//
//  Fetchable.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/13/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation
import Alamofire

protocol Fetchable {
    static var path: String {get}
    static func fetch(error error: Void -> Void, callback: [Self] -> Void)
    static func parse(json: AnyObject) -> Self
}

extension Fetchable {
    /**
     Makes an asynchronous request to the LAH API to fetch the latest items,
     and calls the callback on success.
     Retries by recursively calling itself up to 3 times until is successful.
     */
    static func fetch(error error: Void -> Void, callback: [Self] -> Void) {
        fetch(recursiveDepth: 0, error: error, callback: callback)
    }
    
    static func fetch(recursiveDepth recursiveDepth: Int, error: Void -> Void, callback: [Self] -> Void) {
        
        guard recursiveDepth < 3 else { error(); return }
        
        let url = LAHConstants.BaseAPIURLString + self.path
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            guard
                let json = try? NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments),
                jsonArr = json as? [AnyObject] else {
                // recurse
                fetch(recursiveDepth: recursiveDepth+1, error: error, callback: callback)
                return
            }
            
            let parsed = jsonArr.map(parse)
            
            callback(parsed)
        }
    }
}

extension Fetchable where Self: Cacheable {
    static func updateCache(error error: Void -> Void) {
        Self.fetch(error: error, callback: Self.store)
    }
}
