//
//  InventoryDetail.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 6/12/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InventoryDetail: UIViewController, saveQrDelegate {

    
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var EquipmentName: UILabel!
    @IBOutlet weak var EquipmentPrice: UILabel!
    
    var playerNameString: String?
    var equipmentNameString: String?
    var equipmentPriceString: String?
    var qrCodeDict: NSDictionary?
    var indexToItem: Int?
    var selectedPlayer: Player?
    var isTimeToGetOut: Bool = false
    var theArray: [inventoryItem]?
    let ref = FIRDatabase.database().reference(withPath: "InventoryItems")
    var runAmount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayerName.text = playerNameString
        EquipmentName.text = equipmentNameString
        EquipmentPrice.text = equipmentPriceString
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        runAmount = 0
        if isTimeToGetOut {
            performSegue(withIdentifier: "getOut", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveQr(qrCode: String, backView: String) {
        if backView == "inventoryDetail" {
            findIfQrIsInInventoryItem(qrCode: qrCode)
        }
    }
    
    func findIfQrIsInInventoryItem(qrCode: String){
        
        
        
            if selectedPlayer?.items[indexToItem!].size[selectedPlayer?.items[indexToItem!].qrCode] as! String == qrCode {
                
                isTimeToGetOut = true
                if runAmount == 0 {
                    findQr(inputQrCode: qrCode)
                    runAmount += 1
                }
        }
    }
    
    func findQr(inputQrCode: String){
        //print(inputQrCode)
        //print((theArray[0].size["Small"] as! String))
        //print(selectedPlayer.items.count)
        for item in theArray!{
            if item.qrCode == inputQrCode{
            }
            for (key, value) in item.size{
                //print(value as! String)
                if (value as! String) == inputQrCode {
                    item.changeSize(size: (key as! String), amount: 1)
                    item.ref?.removeValue()
                    let tempRef = ref.child(item.name.lowercased())
                    tempRef.setValue(item.toDict())
                   
                }
                
            }
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "qrCodeFind" {
            let destination:QRReaderViewController = segue.destination as! QRReaderViewController
            destination.delegate = self
            destination.backView = "inventoryDetail"
            
        }
        if segue.identifier == "getOut" {
            let destination:PlayerDetail = segue.destination as! PlayerDetail
            destination.selectedPlayer = selectedPlayer!
            destination.handleDeleteInventoryItem(indexToItem: indexToItem!)
        }
        if segue.identifier == "Done" {
            let destination:PlayerDetail = segue.destination as! PlayerDetail
            destination.selectedPlayer = selectedPlayer!
        }
    }
    

}
