//
//  SignInViewController.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 4/30/18.
//  Copyright © 2018 Malcolm Machesky. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var EmailTextView: UITextField!
    @IBOutlet weak var PasswordTextView: UITextField!
    
    private var email: String?
    private var password: String?
    
    private var currentUser: User?
    
    @IBAction func DoneUIButton(_ sender: Any) {
    
        //Give values to private vars
        email = EmailTextView.text
        password = PasswordTextView.text
        
        //Auth
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "signInSegue", sender: sender)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                 self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }
    }
    
    
    
    
}
