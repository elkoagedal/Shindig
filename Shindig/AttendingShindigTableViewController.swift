//
//  AttendingShindigTableViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import Firebase
import FirebaseDatabase
/*
class AttendCustomCell: UITableViewCell {
    @IBOutlet weak var ShindigName: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var HostLabel: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    
}
 */

class AttendingShindigTableViewController: UITableViewController {
    
    /*
    var event : ShindigAttendingRealm?
    
    var myAttendingEvents : RLMResults<ShindigAttendingRealm> {
        get {
            return ShindigAttendingRealm.allObjects() as! RLMResults<ShindigAttendingRealm>
        }
    }
    */
    var shindigs : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
        var numInvited = 0
        
        var ref = Database.database().reference().child("Users").child(UserDefaults.standard.string(forKey: "Username")!).child("attending")
        var dat = ref.observe(.value, with: { (snapshot) in
            
            if !snapshot.exists() {
                let alertController = UIAlertController(title: "Not Attending Any Shindigs", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
            else {
                let dictionary = snapshot.value as! NSDictionary
                for (key, value) in dictionary {
                    numInvited = numInvited + 1
                    self.shindigs.append(key as! String)
                    print(key)
                    self.tableView.reloadData()
                    
                }
            }
            
        })
        
        return numInvited
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAttendingEvents", for: indexPath)
        
        var k = shindigs[indexPath.row]
        var d = Database.database().reference().child("Events").child(k)
        
        var d2 = d.observe(.value, with: { (snapshot) in
            
            // If no supplies exist, display alert
            if !snapshot.exists() {
                let alertController = UIAlertController(title: "Not Attending Any Shindigs", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
                
                // Put supplies in the supplies array
            else {
                let dict1 = snapshot.value as! NSDictionary
                
                for (key, value) in dict1 {
                    if (key as! String == "name") {
                        cell.textLabel?.text = value as! String
                    }
                    if (key as! String == "date") {
                        cell.detailTextLabel?.text = value as! String
                    }
                    
                }
            }
            
        })

        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "attendingEventDetails") {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            
            let details = segue.destination as! UINavigationController
            let details2 = details.topViewController as! HPOverviewViewController
            
            details2.key = shindigs[(indexPath?.row)!]
        }
    }

}
