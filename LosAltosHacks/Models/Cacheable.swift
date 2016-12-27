//
//  Cacheable.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/19/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Foundation

protocol Cacheable: JSONConvertible {
    static var cacheKey: String {get}
    static func cached() -> [Self]?
    static func store(_ cache: [Self])
    static func clear()
    static var delegates: [CacheableDelegate] {get}
}

class WeakCacheableDelegate<T>: CacheableDelegate where T: AnyObject, T: CacheableDelegate {
    weak var value: T?

    init(_ value: T) {
        self.value = value
    }

    func didUpdateCache() {
        value?.didUpdateCache()
    }
}

protocol CacheableDelegate: class {
    func didUpdateCache()
}

extension Cacheable {

    static var delegates: [CacheableDelegate] { return [] }

    static func cached() -> [Self]? {

        // get json string from cache
        guard let cacheJsonString = UserDefaults.standard.string(forKey: cacheKey) else { return nil }

        // turn json string into nsdata
        guard let jsonData = cacheJsonString.data(using: String.Encoding.utf8) else { return nil }

        // turn json data into a json object
        guard let jsonObj = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) else { return nil }

        // turn json object into array of json strings
        guard let jsonArr = jsonObj as? [String] else { return nil }

        // parse each json string into a "Self"
        // using the do/catch as an early return
        do {
            let items: [Self] = try jsonArr.map {
                let data = $0.data(using: String.Encoding.utf8)!
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return Self.init(json: json)
            }
            return items
        } catch {
            return nil
        }
    }
    
    static func store(_ cache: [Self]) {

        // turn each into a json string
        let json = cache
            .map { $0.asJSON }
            .map { try! JSONSerialization.data(withJSONObject: $0, options: []) }
            .map { String(data: $0, encoding: String.Encoding.utf8) }

        // should just be an array of strings, so force the try
        let jsonObj = try! JSONSerialization.data(withJSONObject: json, options: [])
        let jsonString = String(data: jsonObj, encoding: String.Encoding.utf8)

        UserDefaults.standard.set(jsonString, forKey: cacheKey)
        UserDefaults.standard.synchronize()

        delegates.forEach { $0.didUpdateCache() }
    }

    static func clear() {
        UserDefaults.standard.set(nil, forKey: cacheKey)
        UserDefaults.standard.synchronize()
    }
}

extension Cacheable where Self: Sortable {
    static func cached(sort: Bool) -> [Self]? {
        guard let cached = cached() else { return nil }
        guard sort else { return cached }
        return Self.sort(cached)
    }
}
