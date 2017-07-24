//
//  InventoryofItems.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 7/24/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InventoryofItems: UIViewController, UITableViewDataSource,UITableViewDelegate {

    
    
    
    @IBOutlet weak var TableView: UITableView!
    let ref = FIRDatabase.database().reference(withPath: "InventoryItems")
    
    var items: [inventoryItem] = []
    
    var names: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
        TableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        for i in 0 ..< items.count {
            for (key, value) in items[i].amount{
                if(value != nil) {
                    numRows += 1
                    names.append(items[i].name + " " + (key as! String).capitalized + ": " + (value as! String))
                }
            }
        }
        return numRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func getData(){
        ref.observe(.value, with: { snapshot in
            var newItems: [inventoryItem] = []
            
            for item in snapshot.children {
                newItems.append(inventoryItem(snapshot: item as! FIRDataSnapshot))
            }
            self.items = newItems
            self.TableView.reloadData()
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
