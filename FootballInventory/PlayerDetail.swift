//
//  PlayerDetail.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/24/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit

class PlayerDetail: UIViewController, saveQrDelegate {

    var firstName = ""
    var lastName = ""
    
   
    
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
    
    func saveQr( qrCode: String, backView: String){
        
    }

    

}
