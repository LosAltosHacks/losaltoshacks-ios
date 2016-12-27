//
//  FirebaseManager.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/27/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import Firebase

class FirebaseManager {
    static let shared = FirebaseManager(reference: FIRDatabase.database().reference())

    let root: FIRDatabaseReference
    init(reference: FIRDatabaseReference) {
        self.root = reference
    }

    func events(callback: @escaping ([Event]) -> ()) {
        root.child("schedule").observe(.value) { (snapshot: FIRDataSnapshot) in
            let events = snapshot.children
                .map { ($0 as! FIRDataSnapshot).value }
                .map(Event.init(json:))
            callback(events)
        }
    }

    func updates(callback: @escaping ([Update]) -> ()) {
        root.child("updates").observe(.value) { (snapshot: FIRDataSnapshot) in
            let updates = snapshot.children
                .map { ($0 as! FIRDataSnapshot).value }
                .map(Update.init(json:))
            callback(updates)
        }
    }
}
