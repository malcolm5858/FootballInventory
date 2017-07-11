//
//  PlayerDetail.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/24/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI

class PlayerDetail: UIViewController, saveQrDelegate, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate{
    var firstName = ""
    var lastName = ""
    var playerIndex = 0
    var selectedPlayer: Player = Player(firstName: "", lastName: "", items: [], email: "")
    var deleteRowIndex: NSIndexPath? = nil
    var theArray: [inventoryItem] = []
    var addNum = 0
    @IBOutlet weak var tableView: UITableView!
    let ref = FIRDatabase.database().reference(withPath: "InventoryItems")
    let ref2 = FIRDatabase.database().reference(withPath: "Players")
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendEmail(_ sender: Any) {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([selectedPlayer.email])
        var totalPrice = 0
        for x in 0 ..< self.selectedPlayer.items.count {
            totalPrice += Int(selectedPlayer.items[x].price)!
        }
        mailVC.setSubject("Equipment not returned")
        mailVC.setMessageBody("Your child \(firstName) has not returned there equitment worth \(String(totalPrice))$ and needs to be returned or you will be fined", isHTML: false)
        present(mailVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        addNum = 0
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        getDataInArray()
        tableView.reloadData()
        print(selectedPlayer.items.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlayer.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = selectedPlayer.items[indexPath.row].name
        return cell
    }
   
    func handleDeleteInventoryItem(indexToItem: Int){
        
            selectedPlayer.ref?.removeValue()
            selectedPlayer.items.remove(at: indexToItem)
            selectedPlayer.itemDicts = []
            let tempRef = ref2.child(selectedPlayer.firstName.lowercased())
            tempRef.setValue(selectedPlayer.toDict())
            self.tableView.reloadData()
            deleteRowIndex = nil
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveQr( qrCode: String, backView: String){
        if backView == "PlayerDetail"{
            if(addNum == 0){
                var temp: inventoryItem = findQr(inputQrCode: qrCode)
                if !(temp.name == "" && temp.qrCode == "" && temp.price == ""){
                    selectedPlayer.ref?.removeValue()
                    selectedPlayer.items.append(temp)
                    let tempRef = ref2.child(selectedPlayer.firstName.lowercased())
                    tempRef.setValue(selectedPlayer.toDict())
                    addNum += 1
                }
            }
        }
    }
 
    
    func findQr(inputQrCode: String) -> inventoryItem{
        //print(inputQrCode)
        //print((theArray[0].size["Small"] as! String))
        print(selectedPlayer.items.count)
        for item in theArray{
            if item.qrCode == inputQrCode{
                //print("gotccha")
                return item
            }
            for (key, value) in item.size{
                //print(value as! String)
                if (value as! String) == inputQrCode {
                    return item
                }
                
            }
        }
        return inventoryItem(name: "" , price: "", qrCode: "")
    }
    func getDataInArray(){
        ref.observe(.value, with: { snapshot in
            var temp: [inventoryItem] = []
            
            for item in snapshot.children{
                temp.append(inventoryItem(snapshot: item as! FIRDataSnapshot))
            }
            
            self.theArray = temp
        })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "addEquitment"?:
            let destination:QRReaderViewController = segue.destination as! QRReaderViewController
            destination.delegate = self
            destination.backView = "PlayerDetail"
        case "cellToDetail"?:
            if segue.identifier == "cellToDetail",
                let destination:InventoryDetail = segue.destination as! InventoryDetail,
                let inventoryIndex = tableView.indexPathForSelectedRow?.row
            {
                print(inventoryIndex)
                destination.equipmentNameString = selectedPlayer.items[inventoryIndex].name
                destination.playerNameString = selectedPlayer.firstName + " " + selectedPlayer.lastName
                destination.equipmentPriceString = selectedPlayer.items[inventoryIndex].price
                destination.qrCodeDict = selectedPlayer.items[inventoryIndex].size
                destination.indexToItem = inventoryIndex
                destination.selectedPlayer = selectedPlayer
            }
        default:
            return
        }
    }

    

}
