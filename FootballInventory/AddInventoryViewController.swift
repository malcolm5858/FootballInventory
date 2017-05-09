//
//  AddInventoryViewController.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 2/2/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddInventoryViewController: UIViewController {

    
        var ref: FIRDatabaseReference!
    
    // UISwitch's
    @IBOutlet weak var HasSizes: UISwitch!
    @IBOutlet weak var Small: UISwitch!
    @IBOutlet weak var Medium: UISwitch!
    @IBOutlet weak var Large: UISwitch!
    @IBOutlet weak var XtraLarge: UISwitch!
    @IBOutlet weak var XtraXtraLarge: UISwitch!
    @IBOutlet weak var XtraXtraXtraLarge: UISwitch!
    //Scan Qr Buttons
    @IBOutlet weak var HasSizesQr: UIButton!
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
    @IBAction func HasSizesAction(_ sender: UISwitch) {
        if HasSizes.isOn{
            Small.isEnabled = true
            Medium.isEnabled = true
            Large.isEnabled = true
            XtraLarge.isEnabled = true
            XtraXtraLarge.isEnabled = true
            XtraXtraXtraLarge.isEnabled = true
            HasSizesQr.isEnabled = false
            HasSizesQr.titleLabel?.text = ""
           
        }
        else{
            Small.isEnabled = true
            Medium.isEnabled = true
            Large.isEnabled = true
            XtraLarge.isEnabled = true
            XtraXtraLarge.isEnabled = true
            XtraXtraXtraLarge.isEnabled = true
            HasSizesQr.isEnabled = false
            HasSizesQr.titleLabel?.text = "Scan Qr"

        }
    }
    @IBAction func SmallAction(_ sender: UISwitch) {
        if sender.isOn{
            SmallQr.isEnabled = true
            SmallQr.setTitle("Scan Qr", for: .normal)
        }
        else{
            SmallQr.setTitle("", for: .normal)        }
    }
    @IBAction func MediumAction(_ sender: UISwitch){
        if sender.isOn{
            MediumQr.isEnabled = true
            MediumQr.titleLabel?.text = "Scan Qr"
        }
        else{
            MediumQr.isEnabled = false
            MediumQr.titleLabel?.text = ""
        }

    }
    @IBAction func  LargeAction(_ sender: UISwitch){
        if sender.isOn{
            LargeQr.isEnabled = true
            LargeQr.titleLabel?.text = "Scan Qr"
        }
        else{
            LargeQr.isEnabled = false
            LargeQr.titleLabel?.text = ""
        }
    }
    @IBAction func XtraLargeAction(_ sender: UISwitch) {
        if sender.isOn{
            XtraLargeQr.isEnabled = true
            XtraLargeQr.titleLabel?.text = "Scan Qr"
        }
        else{
            XtraLargeQr.isEnabled = false
            XtraLargeQr.titleLabel?.text = ""
        }
    }
    @IBAction func XtraXtraLargeAction(_ sender: UISwitch) {
        if sender.isOn{
            XtraXtraLargeQr.isEnabled = true
            XtraXtraLargeQr.titleLabel?.text = "Scan Qr"
        }
        else{
            XtraXtraLargeQr.isEnabled = false
            XtraXtraLargeQr.titleLabel?.text = ""
        }
    }
    @IBAction func XtraXtraXtraLargeAction(_ sender: UISwitch) {
        if sender.isOn{
            XtraXtraXtraLargeQr.isEnabled = true
            XtraXtraXtraLargeQr.titleLabel?.text = "Scan Qr"
        }
        else{
            XtraXtraXtraLargeQr.isEnabled = false
            XtraXtraXtraLargeQr.titleLabel?.text = ""
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
            case "Small"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
            case "Medium"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
            case "Large"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
            case "XtraLarge"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
            case "XtraXtraLarge"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
            case "XtraXtraXtraLarge"?:
                let destination:QRReaderViewController = segue.destination as! QRReaderViewController
                destination.backView = segue.identifier
            case "DoneSave"?:
                Save()
            default: break
        }
    }
    
    
    func Save() {
        
        if(Small.isOn){
            print("No")
            let inventoryTemp = inventoryItem(name: name.text!, qrCode: "Test", price: price.text!)
            
            let tempRef = self.ref.child((name.text?.lowercased())!)
            tempRef.setValue(inventoryTemp.toDict())
        }
        else{
            let mainInventoryTemp = inventoryItem(name: name.text!, price: price.text!)
            
            let label = name.text?.lowercased()
            if(smallQrCode != nil){
                let tempSmallRef = self.ref.child(label! + "Small")
                let smallInventoryTemp = inventoryItem(itemWithSizes: mainInventoryTemp, qrCode: smallQrCode!, size: "Small")
                tempSmallRef.setValue(smallInventoryTemp.toDict())
            }
            if(mediumQrCode != nil){
                let tempMediumRef = self.ref.child(label! + "Medium")
                let mediumInventoryTemp = inventoryItem(itemWithSizes: mainInventoryTemp, qrCode: mediumQrCode!, size: "Medium")
                tempMediumRef.setValue(mediumInventoryTemp.toDict())
            }
            if(largeQrCode != nil){
                let tempLargeRef = self.ref.child(label! + "Large")
                let largeInventoryTemp = inventoryItem(itemWithSizes: mainInventoryTemp, qrCode: largeQrCode!, size: "Large")
                tempLargeRef.setValue(largeInventoryTemp.toDict())
            }
            if(xtraLargeQrCode != nil){
                let tempXtraLargeRef = self.ref.child(label! + "XtraLarge")
                let XtraLargeInventoryTemp = inventoryItem(itemWithSizes: mainInventoryTemp, qrCode: xtraLargeQrCode!, size: "XtraLarge")
                tempXtraLargeRef.setValue(XtraLargeInventoryTemp.toDict())
            }
            if(xtraXtraLargeQrCode != nil){
                let tempXtraXtraLargeRef = self.ref.child(label! + "XtraXtraLarge")
                let XtraXtraLargeInventoryTemp = inventoryItem(itemWithSizes: mainInventoryTemp, qrCode: xtraXtraLargeQrCode!, size: "XtraXtraLarge")
                tempXtraXtraLargeRef.setValue(XtraXtraLargeInventoryTemp.toDict())
            }
            if(xtraXtraXtraLargeQrCode != nil){
                let tempXtraXtraXtraLargeRef = self.ref.child(label! + "XtraXtraXtraLarge")
                let XtraXtraXtraLargeInventoryTemp = inventoryItem(itemWithSizes: mainInventoryTemp, qrCode: xtraXtraXtraLargeQrCode!, size: "XtraXtraXtraLarge")
                tempXtraXtraXtraLargeRef.setValue(XtraXtraXtraLargeInventoryTemp.toDict())
            }
            
            
        }
        
        
        
    }
    
    
    
    
    

}
