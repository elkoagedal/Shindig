//
//  IPSuppliesTableViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class IPSuppliesTableViewController: UITableViewController {

    var key : String?
    var reference : DatabaseReference = Database.database().reference().child("Events")
    var suppliesOpen : [String] = []
    var suppliesTaken : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var ref = reference.child(key!).child("supplies")
        var dat = ref.observe(.value, with: { (snapshot) in
            
            // If no supplies exist, display alert
            if !snapshot.exists() {
                print(snapshot)
                let alertController = UIAlertController(title: "No Supplies Found", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
                
                // Put supplies in the supplies array
            else {
                let dict1 = snapshot.value as! NSDictionary
                
                for (key, value) in dict1 {
                    var k = key
                    var details = value as! NSDictionary
                    for (key, value) in details {
                        if (key as! String == "taken") {
                            if (value as! String == "false") {
                                self.suppliesOpen.append(k as! String)
                            }
                            if (value as! String == "true") {
                                self.suppliesTaken.append(k as! String)
                            }
                        }
                    }
                    self.tableView.reloadData()
                    
                }
            }
            
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return Int(suppliesOpen.count)
        }
        if section == 1 {
            return Int(suppliesTaken.count)
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "supply1", for: indexPath)
            
            cell.textLabel?.text = suppliesOpen[indexPath.row]
            
            cell.accessoryType = .none
            
            return cell
        }
        
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "supply2", for: indexPath)
            
            cell.textLabel?.text = suppliesTaken[indexPath.row]
            
            cell.accessoryType = .checkmark
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "supply", for: indexPath)
        
        cell.textLabel?.text = ""
        
        return cell
        
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
