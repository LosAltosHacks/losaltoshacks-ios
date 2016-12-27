//
//  JSONConvertible.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/20/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

protocol JSONEncodable {
    func toJSON() -> String
}

protocol JSONDecodable {
    static func parse(_ json: Any) -> Self
}

protocol JSONConvertible: JSONEncodable, JSONDecodable {}
