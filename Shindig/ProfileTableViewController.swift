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


class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var BirthdayLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var CollegeLabel: UILabel!
    @IBOutlet weak var YourShindigsLabel: UILabel!
    @IBOutlet weak var AttendingShindigsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        if let _ = FBSDKAccessToken.current()
        {
            fetchUserProfile()
        }
        
        
        }
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    
    

  
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func fetchUserProfile() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        graphRequest.start(completionHandler: {(connection, Result, Error) -> Void in
            
            if ((Error) != nil) {
                print("Error")
            }else {
                print("Fetched Result: \(String(describing: Result))")
            
           //     if let id = Result as? [String: Any]
                
             //   print("User ID is: \(id)")
                
                
                if let profilePictureObj = Result as? [String: Any]
                //value(forKey: "picture") as! NSDictionary
                {
                    

                    let data = profilePictureObj["data"] as! NSDictionary

                    let pictureUrlString  = data["url"] as! String
                    let pictureUrl = NSURL(string: pictureUrlString)
                    
                    /*
                    let data = picture["data"] as? [String: Any]
                    let picture = jsondata["picture"] as? [String: Any]
                    let pitctureUrl = data["url"] as? String
                     */
                    
             //      DispatchQueue.global(DispatchQueue.GlobalQueuePriority.default, 0).async() {
                    
                        let imageData = NSData(contentsOf: pictureUrl! as URL)
                        
                        DispatchQueue.main.async() {
                            if let imageData = imageData
                            {
                                let profileImageView = UIImage(data: imageData as Data)

                                self.profileImage.image = profileImageView
                                self.profileImage.contentMode = UIViewContentMode.scaleAspectFit

                            }
                        }
                    }
                }
            }
    )}



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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Some navigation Items
        if indexPath.section == 2 && indexPath.row == 3 {
            self.tabBarController?.selectedIndex = 1
        }
        if indexPath.section == 2 && indexPath.row == 4 {
            self.tabBarController?.selectedIndex = 0
        }
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
