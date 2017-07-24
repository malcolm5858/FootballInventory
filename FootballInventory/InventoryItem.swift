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
    let qrCode: String
    var size: NSDictionary = [:]
    let ref: FIRDatabaseReference?
    let price: String
    var amount: NSMutableDictionary = [:]
    
    init(name: String, price: String, qrCode: String){
        self.name = name
        self.price = price
        self.qrCode = qrCode
        amount = [:]
        size = [:]
        ref = nil
    }
    init(name: String, qrCode: String, price: String, size: NSDictionary, amount: NSMutableDictionary){
        self.name = name
        self.qrCode = qrCode
        self.price = price
        self.size = size
        self.amount = amount
        ref = nil
    }
    init(snapshot: FIRDataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = snapshotValue["name"] as! String
        self.qrCode = snapshotValue["qrCode"] as! String
        if(snapshotValue["size"] != nil){
            self.size = snapshotValue["size"] as! NSDictionary
        }
        else{
            self.size = [:]
        }
        if(snapshotValue["amount"] != nil){
            self.amount = snapshotValue["amount"] as! NSMutableDictionary
        }
        else{
            self.amount = [:]
        }
        self.price = snapshotValue["Price"] as! String
        self.ref = snapshot.ref
    }
    init(dictonary: NSDictionary)
    {
        self.name = dictonary["name"] as! String
        self.qrCode = dictonary["qrCode"] as! String
        self.size = dictonary["size"] as! NSDictionary
        self.price = dictonary["Price"] as! String
        self.amount = dictonary["amount"] as! NSMutableDictionary
        self.ref = nil
    }
    func toDict() -> Any {
        return ["name": name, "qrCode": qrCode, "size": size, "Price": price, "amount": amount as! NSDictionary]
    }
    
    func changeSize(size: String, amount: Int){
        var temp = self.amount[size] as! Int
        temp += amount
        self.amount[size] = temp
    }
    
    
}
