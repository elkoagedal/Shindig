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


class AttendingShindigTableViewController: UITableViewController {
    
   
    var shindigs : [String] = []
    var numberInvited : Int?
    var ref : DatabaseReference! = Database.database().reference()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        var reference = ref.child("Users").child(UserDefaults.standard.string(forKey: "Username")!).child("attending")
        var dat = reference.observe(.value, with: { (snapshot) in
            
            // If no shindigs exist, display alert
            if snapshot.exists() {
                let dict1 = snapshot.value as! NSDictionary
                for (key, value) in dict1 {
                    self.shindigs.append(key as! String)
                    self.tableView.reloadData()
                }
            }
            // Put shindigs in the table
        })

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shindigs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAttendingEvents", for: indexPath)
        
        var a = ref.child("Events").child(shindigs[indexPath.row])
        var dat = a.observe(.value, with: { (snapshot) in
            
            // If no shindigs exist, display alert
            if snapshot.exists() {
                let dictionary = snapshot.value as! NSDictionary
                for (key, value) in dictionary {
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
