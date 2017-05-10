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
    var items: [inventoryItem]
    var itemDicts: [NSDictionary]
    
    init(firstName: String, lastName: String, items: [inventoryItem]) {
        self.firstName = firstName
        self.lastName = lastName
        self.ref = nil
        self.items = items
        self.itemDicts = []
    }
    
    init(snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.firstName = snapshotValue["firstName"] as! String
        self.lastName = snapshotValue["lastName"] as! String
        self.ref = snapshot.ref
        self.itemDicts = snapshotValue["items"] as! [NSDictionary]
        self.items = []
        
    }
    func addInventoryItem(itemToAdd: inventoryItem){
        items.append(itemToAdd)
    }
    func toDict() -> Any {
        for x in 0 ..< items.count{
            itemDicts[x] = items[x].toDict() as! NSDictionary
        }
        return ["firstName": firstName, "lastName": lastName, "items": itemDicts]
    }
    
    
}
