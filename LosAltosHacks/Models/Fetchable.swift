//
//  Fetchable.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/13/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation
import Alamofire

protocol Fetchable: JSONDecodable {
    static var path: String {get}
    static func fetch(error: @escaping (Void) -> Void, callback: @escaping ([Self]) -> Void)
}

extension Fetchable {
    /**
     Makes an asynchronous request to the LAH API to fetch the latest items,
     and calls the callback on success.
     Retries by recursively calling itself up to 3 times until is successful.
     */
    static func fetch(error: @escaping (Void) -> Void, callback: @escaping ([Self]) -> Void) {
        fetch(recursiveDepth: 0, error: error, callback: callback)
    }

    static func fetch(recursiveDepth: Int, error: @escaping (Void) -> Void, callback: @escaping ([Self]) -> Void) {
        
        guard recursiveDepth < 3 else { error(); return }
        
        let url = LAHConstants.BaseAPIURLString + self.path
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        Alamofire.request(request).responseJSON { response in
            
            guard
                let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments),
                let jsonArr = json as? [AnyObject] else {
                // recurse
                fetch(recursiveDepth: recursiveDepth+1, error: error, callback: callback)
                return
            }
            
            let parsed = jsonArr.map(parse)
            callback(parsed)
        }
    }
}

extension Fetchable where Self: Sortable {
    /**
     Makes an asynchronous request to the LAH API to fetch the latest items,
     and calls the callback on success.
     
     Retries by recursively calling itself up to 3 times until is successful.
     
     Sorts the items before passing to the callback if the sort parameter is true (default: true)
     */
    static func fetch(sort: Bool = true, error: @escaping (Void) -> Void, callback: @escaping ([Self]) -> Void) {
        fetch(error: error, callback: {sort ? callback(Self.sort($0)) : callback($0)})
    }
}

extension Fetchable where Self: Cacheable {
    static func updateCache(error: @escaping (Void) -> Void) {
        Self.fetch(error: error, callback: Self.store)
    }
}


extension Fetchable where Self: Cacheable, Self: Sortable {
    static func updateCache(sort: Bool, error: @escaping (Void) -> Void) {
        Self.fetch(sort: sort, error: error, callback: {Self.store($0)})
    }
}
