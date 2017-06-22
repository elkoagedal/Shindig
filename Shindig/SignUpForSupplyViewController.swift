//
//  SignUpForSupplyViewController.swift
//  Shindig
//
//  Created by Ryann Consalo on 2017/06/22.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpForSupplyViewController: UIViewController {
    
    var key : String?
    var supplyName : String?
    var ref : DatabaseReference! = Database.database().reference().child("Events")

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var supplyNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        var dataRef = ref.child(key!).child("supplies").child(supplyName!).child("taken").setValue("true")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataRefe = ref.child(key!).child("supplies").child(supplyName!)
        var dat = dataRefe.observe(.value, with: { (snapshot) in
            
            // If no supplies exist, display alert
            if !snapshot.exists() {
                let alertController = UIAlertController(title: "No Supply Found", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
                
                // Put supplies in the supplies array
            else {
                let dict1 = snapshot.value as! NSDictionary
                print (dict1)
                
                for (key, value) in dict1 {
                    if ((key as! String) == "supply price") {
                        self.priceLabel.text = value as! String
                    }
                    
                }
            }
        })
        
        self.supplyNameLabel.text = supplyName

        var dataReference = ref.child(key!)
        var info = dataReference.observe(.value, with: { (snapshot) in
            
            // If no supplies exist, display alert
            if !snapshot.exists() {
                let alertController = UIAlertController(title: "Not Found", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
                
                // Put supplies in the supplies array
            else {
                let dict2 = snapshot.value as! NSDictionary
                
                for (key, value) in dict2 {
                    if ((key as! String) == "name") {
                        self.eventNameLabel.text = value as! String
                    }
                    
                }
            }
        })


        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
