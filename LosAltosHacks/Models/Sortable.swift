//
//  Sortable.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/20/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

protocol Sortable {
    static func sort(items: [Self]) -> [Self]
}
