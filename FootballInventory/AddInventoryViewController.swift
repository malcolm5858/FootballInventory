//
//  AddInventoryViewController.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 2/2/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddInventoryViewController: UIViewController, saveQrDelegate{

    
        var ref: FIRDatabaseReference!
    
    // UISwitch's
   // @IBOutlet weak var HasSizes: UISwitch!
    @IBOutlet weak var Small: UISwitch!
    @IBOutlet weak var Medium: UISwitch!
    @IBOutlet weak var Large: UISwitch!
    @IBOutlet weak var XtraLarge: UISwitch!
    @IBOutlet weak var XtraXtraLarge: UISwitch!
    @IBOutlet weak var XtraXtraXtraLarge: UISwitch!
    //Scan Qr Buttons
    //@IBOutlet weak var HasSizesQr: UIButton!
    @IBOutlet weak var SmallQr: UIButton!
    @IBOutlet weak var MediumQr: UIButton!
    @IBOutlet weak var LargeQr: UIButton!
    @IBOutlet weak var XtraLargeQr: UIButton!
    @IBOutlet weak var XtraXtraLargeQr: UIButton!
    @IBOutlet weak var XtraXtraXtraLargeQr: UIButton!
    //Text feilds
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    //Qr Codes
    var deafaultQrCode: String?
    var smallQrCode: String?
    var mediumQrCode: String?
    var largeQrCode: String?
    var xtraLargeQrCode: String?
    var xtraXtraLargeQrCode: String?
    var xtraXtraXtraLargeQrCode: String?
    //Amount input
    @IBOutlet weak var SmallAmount: UITextField!
    @IBOutlet weak var MediumAmount: UITextField!
    @IBOutlet weak var LargeAmount: UITextField!
    @IBOutlet weak var XtraLargeAmount: UITextField!
    @IBOutlet weak var XtraXtraLargeAmount: UITextField!
    @IBOutlet weak var XtraXtraXtraLargeAmount: UITextField!
    // is Jersey
    @IBOutlet weak var isJersey: UISwitch!
    
    
    
    
    func saveQr(qrCode: String, backView: String) {
        //print("performed")
        switch (backView){
                    case "Small":
                            smallQrCode = qrCode
                    case "Medium":
                            mediumQrCode = qrCode
                    case "Large":
                            largeQrCode = qrCode
                    case "XtraLarge":
                            xtraLargeQrCode = qrCode
                    case "XtraXtraLarge":
                            xtraXtraLargeQrCode = qrCode
                    case "XtraXtraXtraLarge":
                        xtraXtraXtraLargeQrCode = qrCode
                    default: break
                    }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference(withPath: "InventoryItems")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //UISwitchActions
//    @IBAction func HasSizesAction(_ sender: UISwitch) {
//        
//            Small.isEnabled = true
//            Medium.isEnabled = true
//            Large.isEnabled = true
//            XtraLarge.isEnabled = true
//            XtraXtraLarge.isEnabled = true
//            XtraXtraXtraLarge.isEnabled = true
//            //HasSizesQr.isEnabled = false
//            //HasSizesQr.titleLabel?.text = ""
//           
//        
//        else{
//            Small.isEnabled = true
//            Medium.isEnabled = true
//            Large.isEnabled = true
//            XtraLarge.isEnabled = true
//            XtraXtraLarge.isEnabled = true
//            XtraXtraXtraLarge.isEnabled = true
//            //HasSizesQr.isEnabled = false
//            //HasSizesQr.titleLabel?.text = "Scan Qr"
//
//        }
//    }
    @IBAction func SmallAction(_ sender: UISwitch) {
        if sender.isOn{
            SmallQr.isEnabled = true
            SmallQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            SmallQr.setTitle("", for: .normal)
            SmallQr.isEnabled = false
        }
    }
    @IBAction func MediumAction(_ sender: UISwitch){
        if sender.isOn{
            MediumQr.isEnabled = true
            MediumQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            MediumQr.setTitle("", for: .normal)
            MediumQr.isEnabled = false
        }

    }
    @IBAction func  LargeAction(_ sender: UISwitch){
        if sender.isOn{
            LargeQr.isEnabled = true
            LargeQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            LargeQr.setTitle("", for: .normal)
            LargeQr.isEnabled = false
        }
    }
    @IBAction func XtraLargeAction(_ sender: UISwitch) {
        if sender.isOn{
            XtraLargeQr.isEnabled = true
            XtraLargeQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            XtraLargeQr.setTitle("", for: .normal)
            XtraLargeQr.isEnabled = false
        }
    }
    @IBAction func XtraXtraLargeAction(_ sender: UISwitch) {
        if sender.isOn{
            XtraXtraLargeQr.isEnabled = true
            XtraXtraLargeQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            XtraXtraLargeQr.setTitle("", for: .normal)
            XtraXtraLargeQr.isEnabled = false
        }
    }
    @IBAction func XtraXtraXtraLargeAction(_ sender: UISwitch) {
        if sender.isOn{
            XtraXtraXtraLargeQr.isEnabled = true
            XtraXtraXtraLargeQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            XtraXtraXtraLargeQr.setTitle("", for: .normal)
            XtraXtraXtraLargeQr.isEnabled = false
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
            case "Small"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
                destination.delegate = self
            case "Medium"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
                destination.delegate = self
            case "Large"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
                destination.delegate = self
            case "XtraLarge"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
                destination.delegate = self
            case "XtraXtraLarge"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
                destination.delegate = self
            case "XtraXtraXtraLarge"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
                destination.delegate = self
            case "DoneSave"?:
                Save()
            default: break
        }
    }
    
    
    func Save() {
        
        

            var sizes: NSMutableDictionary = NSMutableDictionary()
            var amount: NSMutableDictionary = NSMutableDictionary()
            let label = name.text?.lowercased()
            if(smallQrCode != nil){
                sizes["Small"] = smallQrCode
                amount["Small"] = Int(SmallAmount.text!)
            }
            if(mediumQrCode != nil){
                sizes["medium"] = mediumQrCode
                amount["medium"] = Int(MediumAmount.text!)
            }
            if(largeQrCode != nil){
                sizes["Large"] = largeQrCode
                amount["Large"] = Int(LargeAmount.text!)
            }
            if(xtraLargeQrCode != nil){
                sizes["XtraLarge"] = xtraLargeQrCode
                amount["XtraLarge"] = Int(XtraLargeAmount.text!)
            }
            if(xtraXtraLargeQrCode != nil){
               sizes["XtraXtraLarge"] = xtraXtraLargeQrCode
               amount["XtraXtraLarge"] = Int(XtraXtraLargeAmount.text!)
            }
            if(xtraXtraXtraLargeQrCode != nil){
               sizes["XtraXtraXtraLarge"] = xtraXtraXtraLargeQrCode
               amount["XtraXtraXtraLarge"] = Int(XtraXtraXtraLargeAmount.text!)
            }
            var isJerseyText = ""
            if isJersey.isOn {
                isJerseyText = "true"
            }else {
                isJerseyText = "false"
            }
            let inventory: inventoryItem = inventoryItem(name: name.text!, qrCode: "", price: price.text!, size: sizes, amount: amount, isJersey: isJerseyText)
            let tempRef = self.ref.child(label!)
            tempRef.setValue(inventory.toDict())
            
        
        
        
        
    }
    
    
    
    
    

}
