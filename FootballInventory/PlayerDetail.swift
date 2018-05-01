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
    var playerIndex = 0
    var selectedPlayer: Player = Player(firstName: "", lastName: "", items: [], email: "")
    var theArray: [inventoryItem] = []
    var addNum = 0
    @IBOutlet weak var tableView: UITableView!
    var tempSize: String?
    let ref = Database.database().reference(withPath: "InventoryItems")
    let ref2 = Database.database().reference(withPath: "Players")
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
        var allItems = ""
        for item in selectedPlayer.items {
            allItems += item.name + " " + item.qrCode
            allItems += " <br> "
        }
        mailVC.setSubject("Equipment not returned")
        mailVC.setMessageBody("<p> \(selectedPlayer.firstName) \(selectedPlayer.lastName) has not returned the following football equipment. <br> The replacement cost for the equipment is $\(totalPrice).<br> Please email me at pescij@slcs.us to arrange a time to return <br> the equipment or make a payment. <br> <br> \(allItems) <br> <br> Thank you and Be EAST <br> <br> Coach Pesci  </p>", isHTML: true)
        present(mailVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        addNum = 0
        firstNameLabel.text = selectedPlayer.firstName
        lastNameLabel.text = selectedPlayer.lastName
        print(selectedPlayer.items.count)
        for index in 0..<selectedPlayer.items.count {
            if selectedPlayer.items[index].isJersey == "true" && selectedPlayer.items[index].jerseyNum == nil {
                
                let alert = UIAlertController(title: "Jersey", message: "What Jersey Number", preferredStyle: UIAlertControllerStyle.alert)
                
                let action = UIAlertAction(title: "Done", style: .default) {
                    (alertAction) in
                    
                    let textField = alert.textFields![0] as UITextField
                    self.selectedPlayer.ref?.removeValue()
                    let temp = self.selectedPlayer.items[index]
                    self.selectedPlayer.items.remove(at: index)
                    self.selectedPlayer.itemDicts = []
                    temp.isJersey = textField.text!
                    self.selectedPlayer.items.append(temp)
                    let tempRef = self.ref2.child(self.selectedPlayer.firstName.lowercased() + " " + self.selectedPlayer.lastName.lowercased())
                    tempRef.setValue(self.selectedPlayer.toDict())
                    self.tableView.reloadData()
                }
                
                alert.addTextField { (textField) in
                    
                    textField.placeholder = "Enter Jersey Number"
                    
                }
                
                alert.addAction(action)
                
                present(alert, animated: true, completion:  nil)
                
            }
        }
        getDataInArray()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedPlayer.items.count)
        return selectedPlayer.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var textForCell = selectedPlayer.items[indexPath.row].name + " " + selectedPlayer.items[indexPath.row].qrCode
        
        if selectedPlayer.items[indexPath.row].isJersey != "true" && selectedPlayer.items[indexPath.row].isJersey != "false" {
            textForCell += " " + (selectedPlayer.items[indexPath.row].isJersey as String)
        }
        cell.textLabel?.text = textForCell
        return cell
    }
   
    func handleDeleteInventoryItem(indexToItem: Int){
        
            selectedPlayer.ref?.removeValue()
            selectedPlayer.items.remove(at: indexToItem)
            selectedPlayer.itemDicts = []
            let tempRef = ref2.child(selectedPlayer.firstName.lowercased() + " " + selectedPlayer.lastName.lowercased())
            tempRef.setValue(selectedPlayer.toDict())
        
        
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
                    selectedPlayer.itemDicts = []
                    temp.qrCode = tempSize!
                    selectedPlayer.items.append(temp)
                    let tempRef = ref2.child(selectedPlayer.firstName.lowercased() + " " + selectedPlayer.lastName.lowercased())
                    tempRef.setValue(selectedPlayer.toDict())
                    addNum += 1
                    tempSize = ""
                }
            }
            
        }
    }
 
    
    func findQr(inputQrCode: String) -> inventoryItem{
        //print(inputQrCode)
        //print((theArray[0].size["Small"] as! String))
        //print(selectedPlayer.items.count)
        for item in theArray{
            if item.qrCode == inputQrCode{
                //print("gotccha")
                return item
            }
            for (key, value) in item.size{
                //print(value as! String)
                if (value as! String) == inputQrCode {
                    tempSize = key as! String
                    item.changeSize(size: tempSize!, amount: -1)
                    item.ref?.removeValue()
                    let tempRef = ref.child(item.name.lowercased())
                    tempRef.setValue(item.toDict())
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
                temp.append(inventoryItem(snapshot: item as! DataSnapshot))
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
                //print(inventoryIndex)
                destination.equipmentNameString = selectedPlayer.items[inventoryIndex].name
                destination.playerNameString = selectedPlayer.firstName + " " + selectedPlayer.lastName
                destination.equipmentPriceString = selectedPlayer.items[inventoryIndex].price
                destination.qrCodeDict = selectedPlayer.items[inventoryIndex].size
                destination.indexToItem = inventoryIndex
                destination.selectedPlayer = selectedPlayer
                destination.theArray = self.theArray
            }
        default:
            return
        }
    }

    

}
