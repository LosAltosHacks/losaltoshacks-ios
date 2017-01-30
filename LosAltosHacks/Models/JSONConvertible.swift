//
//  JSONConvertible.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/20/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

protocol JSONEncodable {
    var asJSON: [String:Any] {get}
}

protocol JSONDecodable {
    init?(json: Any)
}

protocol JSONConvertible: JSONEncodable, JSONDecodable {}
