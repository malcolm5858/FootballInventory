//
//  PlayerDetail.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/24/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PlayerDetail: UIViewController, saveQrDelegate {

    var firstName = ""
    var lastName = ""
    var playerIndex = 0
    
    let ref = FIRDatabase.database().reference(withPath: "InventoryItems")
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //TODO: need to look at this agian make sure it works 
    func saveQr( qrCode: String, backView: String){
        if backView == "PlayerDetail"{
                    }
    }
    
    func findQr(inputQrCode: String) -> inventoryItem{
        ref.observe(.value, with: { snapshot in
            var returnInventoryItem: inventoryItem
            for item in snapshot.children{
                let snapshotValue = (item as! FIRDataSnapshot).value as! [String: AnyObject]
                if((snapshotValue["qrCode"] as! String) == ""){
                    let dictOfQrCodes = snapshotValue["size"] as! NSDictionary
                    findqrCode: for(_, qrCode) in dictOfQrCodes{
                        if (qrCode as! String) == inputQrCode{
                            returnInventoryItem = inventoryItem(snapshot: item as! FIRDataSnapshot)
                            break findqrCode
                        }
                    }
                }
                else{
                    if((snapshotValue["qrCode"] as! String) == inputQrCode){
                        returnInventoryItem = inventoryItem(snapshot: item as! FIRDataSnapshot)
                        continue
                    }
                    else{
                        continue
                    }
                }
            }
        })
        return returnInventoryItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addEquitment"?:
            let destination:QRReaderViewController = segue.destination as! QRReaderViewController
            destination.backView = "PlayerDetail"
        default:
            return
        }
    }

    

}
