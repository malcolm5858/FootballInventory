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
    let size: String?
    let ref: FIRDatabaseReference?
    let price: String?
    
    init(name: String, price: String){
        self.name = name
        self.price = price
        qrCode = nil
        size = nil
        ref = nil
    }
    init(name: String, qrCode: String, price: String){
        self.name = name
        self.qrCode = qrCode
        self.price = price
        size = nil
        ref = nil
    }
    init(itemWithSizes: inventoryItem, qrCode: String, size: String){
        self.name = itemWithSizes.name
        self.qrCode = qrCode
        self.size = size
        self.price = itemWithSizes.price
        ref = nil
    }
    init(snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.qrCode = snapshotValue["qrCode"] as? String
        self.size = "Small"//snapshotValue["size"] as? String
        self.price = snapshotValue["Price"] as? String
        self.ref = snapshot.ref
    }
    func toDict() -> Any {
        return ["name": name, "qrCode": qrCode, "size": size, "Price": price]
    }
    
    
    
}
