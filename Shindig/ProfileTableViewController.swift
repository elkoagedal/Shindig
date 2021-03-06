//
//  ProfileTableViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore
import Alamofire
import AlamofireImage

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var BirthdayLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var CollegeLabel: UILabel!
    
    @IBAction func yourShindigs(_ sender: Any) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "view2")
        self.present(ViewController!, animated: true, completion: nil)
    }
    
    @IBAction func attendingButton(_ sender: Any) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "view1")
        self.present(ViewController!, animated: true, completion: nil)
    }
    
    /*@IBAction func yourShindigsButton(_ sender: Any) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "view2")
        self.present(ViewController!, animated: true, completion: nil)
    }
 */
    
    
    var userData: [String:Any] = [:]
    var picture: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
        let graphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: params)
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                if let userData = result as? [String:Any] {
                    print(userData)
                    //let data = userData["data"] as! NSArray
                    var d = userData as! NSDictionary
                    for (key, value) in d {
                        if (key as! String == "name") {
                            self.userFullName.text = value as? String
                        }
                        if (key as! String == "email") {
                            self.EmailLabel.text = value as? String
                        }
                        if (key as! String == "picture") {
                            var data = value as! NSDictionary
                            
                            for (key, value) in data {
                                if (key as! String == "data") {
                                    var pict = value as! NSDictionary
                                    for (key, value) in pict {
                                        if (key as! String == "url") {
                                            var picURL = value
                                            print(picURL)
                                        }
                                    }
                                
                                }
                            }
                        }
                        print(d)
                    }
                } else {
                    print("Error Getting Data \(error)");
                }
                
            }
        })
        connection.start()
        

        
        
        
        
        
        
        
        
        /*if (AccessToken.current?.authenticationToken != nil) {
            let user = Auth.auth().currentUser
            
            //deserialising grabbed image
            Alamofire.request((user?.photoURL)!).responseImage { response in
                if let image = response.result.value {
                    self.profileImage.image = image
                }
            }
        }
 */
    }
        
        
        /*
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! NSDictionary
                    print(self.dict)
                //    NSLog(self.dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as String)
                }
            })
        }*/
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    
    

  
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        if section == 2 {
            return 5
        }
        return 0
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
