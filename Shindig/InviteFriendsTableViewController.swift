

//
//  InviteFriendsTableViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FacebookCore
import FacebookLogin
import Firebase
import FirebaseDatabase


class InviteFriendsTableViewController: UITableViewController {
    
    
    var key : String?
    var userData: [String:Any] = [:]
    var friends : [String] = []
    var ids : [String] = []
    //var data: NSDictionary = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
        let graphRequest = FBSDKGraphRequest(graphPath: "/me/friends", parameters: params)
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                if let userData = result as? [String:Any] {
                    //print(userData)
                    let data = userData["data"] as! NSArray
                    print(data)
                    var d = data[0] as! NSDictionary
                    print(d)
                    for (key, value) in d {
                        if (key as! String == "name") {
                            self.friends.append(value as! String)
                        }
                        if (key as! String == "id") {
                            self.ids.append(value as! String)
                        }
                    }
                    self.tableView.reloadData()
                    
                    print(data)
                }
            } else {
                print("Error Getting Friends \(error)");
            }
            
        })
        
        connection.start()
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteFriendsCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = friends[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        var id = ids[indexPath.row]
        var ref = Database.database().reference().child("Users").child(id).child("attending").child(key!).setValue("invited")
        
        
    }
    
    
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

