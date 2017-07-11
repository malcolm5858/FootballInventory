//
//  ViewControllerAddPlayer.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/19/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewControllerAddPlayer: UIViewController {

    var firstName :String = "test"
    var lastName : String = "test"
    var email : String = "test"
    
    let ref = FIRDatabase.database().reference(withPath: "Players")
    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
   

    @IBAction func Save(_ sender: UIButton) {
        if firstNameInput.text != "" && lastNameInput.text != ""{
            firstName = firstNameInput.text!
            lastName = lastNameInput.text!
            email = emailInput.text!
            //let testInventoryItem = inventoryItem(name: "NN", qrCode: "222", price: "22", size: ["Small": "22"])
            let playerTemp = Player(firstName: firstName, lastName: lastName, items: [], email: email)
            
            let tempRef = self.ref.child(firstName.lowercased())
            tempRef.setValue(playerTemp.toDict())
            
            //print("added objects")
            performSegue(withIdentifier: "goToTable", sender: sender)
        }
        
        
    }
    
    
    

   

}
