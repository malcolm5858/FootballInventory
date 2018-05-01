//
//  AppDelegate.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/19/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.storyboard =  UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil
        {
            self.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "Menu")
        }
        else
        {
         self.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "login")
        }
        return true
    }
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }

    
}

