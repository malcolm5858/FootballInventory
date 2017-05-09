//
//  Player.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/25/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class Player{
    let firstName: String
    let lastName: String
    let ref: FIRDatabaseReference?
    let items: [String]
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.ref = nil
        self.items = []
    }
    
    init(snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.firstName = snapshotValue["firstName"] as! String
        self.lastName = snapshotValue["lastName"] as! String
        self.ref = snapshot.ref
        self.items = snapshotValue["items"] as! [String]
    }
    
    func toDict() -> Any {
        return ["firstName": firstName, "lastName": lastName, "items": items]
    }
    
    
}
