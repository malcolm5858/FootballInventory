//
//  ViewController.swift
//  FootballInventory
//
//  Created by Malcolm Machesky on 1/23/17.
//  Copyright © 2017 Malcolm Machesky. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    var players: [Player] = []
    var tempFirstName = ""
    var tempLastName = ""
    var deleteRowIndex: NSIndexPath? = nil
    
    let ref = FIRDatabase.database().reference(withPath: "Players")
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.delegate = self;
        // Do any additional setup after loading the view.
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row].firstName + " " + players[indexPath.row].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteRowIndex = indexPath as NSIndexPath?
            let rowToDelete = players[indexPath.row]
            confirmDelete(Player: rowToDelete)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetail",
            let destination:PlayerDetail = segue.destination as! PlayerDetail,
            let playerIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.firstName = players[playerIndex].firstName
            destination.lastName = players[playerIndex].lastName
            destination.playerIndex = playerIndex
            destination.selectedPlayer = players[playerIndex]
        }
    }
    
    func getData(){
        ref.observe(.value, with: { snapshot in
            var newPlayers: [Player] = []
            
            for item in snapshot.children {
                newPlayers.append(Player(snapshot: item as! FIRDataSnapshot))
            }
            
            self.players = newPlayers
            self.tableView.reloadData()
        })
       
    }
    
    func confirmDelete(Player: Player){
        let alert = UIAlertController(title: "Delete Player", message: "Are you sure you want to delete player \(Player.firstName) \(Player.lastName)", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeletePlayer)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeletePlayer)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.height / 2.0,width:  1.0,height:  1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeletePlayer(alertAction: UIAlertAction!) -> Void{
        
        if let IndexPath = deleteRowIndex{
            let temp = players[IndexPath.row]
            temp.ref?.removeValue()
            getData()
            deleteRowIndex = nil
           
            
        }
    }
    
    func cancelDeletePlayer(alertAction: UIAlertAction!){
        deleteRowIndex = nil
    }
    
}
