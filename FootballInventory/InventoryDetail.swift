//
//  InventoryDetail.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 6/12/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayerName.text = playerNameString
        EquipmentName.text = equipmentNameString
        EquipmentPrice.text = equipmentPriceString
        // Do any additional setup after loading the view.
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
        for item in selectedPlayer?.items
        for (key, value) in item. {
            if value as! String == qrCode {
                performSegue(withIdentifier: "getOut", sender: self)
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
    }
    

}
