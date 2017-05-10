//
//  InventoryItem.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/31/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import Foundation
import FirebaseDatabase
class inventoryItem{
    
    let name: String
    let qrCode: String?
    let size: NSDictionary?
    let ref: FIRDatabaseReference?
    let price: String?
    
    init(name: String, price: String, qrCode: String){
        self.name = name
        self.price = price
        self.qrCode = qrCode
        size = nil
        ref = nil
    }
    init(name: String, qrCode: String, price: String, size: NSDictionary){
        self.name = name
        self.qrCode = qrCode
        self.price = price
        self.size = size
        ref = nil
    }
    init(snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.qrCode = snapshotValue["qrCode"] as? String
        self.size = snapshotValue["size"] as? NSDictionary
        self.price = snapshotValue["Price"] as? String
        self.ref = snapshot.ref
    }
    init(dictonary: NSDictionary)
    {
        self.name = dictonary["name"] as! String
        self.qrCode = dictonary["qrCode"] as? String
        self.size = dictonary["size"] as? NSDictionary
        self.price = dictonary["Price"] as? String
        self.ref = nil
    }
    func toDict() -> Any {
        return ["name": name, "qrCode": qrCode!, "size": size!, "Price": price!]
    }
    
    
    
}
