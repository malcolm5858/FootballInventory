//
//  InventoryViewController.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 2/1/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase


class InventoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var Inventory: [inventoryItem] = []
    var deleteRowIndex: NSIndexPath? = nil
    
    let ref = FIRDatabase.database().reference(withPath: "InventoryItems")
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: tableView setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Inventory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath)
        cell.textLabel?.text = Inventory[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            deleteRowIndex = indexPath as NSIndexPath?
            let rowToDelete = Inventory[indexPath.row]
            confirmDelete(InventoryItem: rowToDelete)
        }
    }
    //MARK: Nav
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    func getData(){
        ref.observe(.value, with: { snapshot in
            var newInventory: [inventoryItem] = []
            
            for item in snapshot.children {
                //print(item)
                newInventory.append(inventoryItem(snapshot: item as! FIRDataSnapshot))
            }
            
            self.Inventory = newInventory
            self.tableView.reloadData()
            //print(self.Inventory.count)
        })
    }
    
    override func viewDidLoad() {
        
        getData()
        print(self.Inventory.count)
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;

        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func confirmDelete(InventoryItem: inventoryItem){
        let alert = UIAlertController(title: "Delete Equitment", message: "Are you sure you want to delete this equitment \(InventoryItem.name)", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteInventoryitem)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteInventoryItem)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleDeleteInventoryitem(alertAction: UIAlertAction!) -> Void{
        if let IndexPath = deleteRowIndex{
            let temp = Inventory[IndexPath.row]
            temp.ref?.removeValue()
            getData()
            deleteRowIndex = nil
        }
    }
    func cancelDeleteInventoryItem (alertAction: UIAlertAction!) {
        deleteRowIndex = nil
    }
    

}
