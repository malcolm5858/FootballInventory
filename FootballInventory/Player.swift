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
    var email: String
    
    
    init(firstName: String, lastName: String, items: [inventoryItem], email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.ref = nil
        self.items = items
        self.itemDicts = []
        self.email = email
    }
    
    init(snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.firstName = snapshotValue["firstName"] as! String
        self.lastName = snapshotValue["lastName"] as! String
        self.ref = snapshot.ref
        self.email = snapshotValue["email"] as! String
        self.items = []
        if(snapshotValue["items"] != nil){
            self.itemDicts = snapshotValue["items"] as! [NSDictionary]
        
            for x in 0 ..< self.itemDicts.count {
                self.items.append(inventoryItem(dictonary: itemDicts[x]))
            }
        }
        else{
            self.itemDicts = []
        }
        
        
    }
    func addInventoryItem(itemToAdd: inventoryItem){
        items.append(itemToAdd)
    }
    func toDict() -> Any {
        for x in 0 ..< items.count{
            //itemDicts[x] = items[x].toDict() as! NSDictionary
            itemDicts.insert(items[x].toDict() as! NSDictionary, at: x)
        }
        return ["firstName": firstName, "lastName": lastName, "items": itemDicts, "email": email]
    }
    
    
}
