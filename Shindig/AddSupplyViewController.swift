//
//  AddSupplyViewController.swift
//  Shindig
//
//  Created by Ryann Consalo on 2017/06/21.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddSupplyViewController: UIViewController {
    
    var key : String?
    var ref : DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var numPeopleTextField: UITextField!
    
    @IBAction func addButton(_ sender: Any) {
        
        ref.child("Events").child(key!).child("supplies").child(nameTextField.text!).child("supply price").setValue(priceTextField.text)
        ref.child("Events").child(key!).child("supplies").child(nameTextField.text!).child("num people").setValue(numPeopleTextField.text)
        ref.child("Events").child(key!).child("supplies").child(nameTextField.text!).child("taken").setValue("false")
        
        priceTextField.text = ""
        nameTextField.text = ""
        numPeopleTextField.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "navToSupplyList") {
            let newSupply = segue.destination as! AddSuppliesTableViewController
            newSupply.key = key
            
        }
        
        if (segue.identifier == "navToAddFriends") {
            let newSupply2 = segue.destination as! InviteFriendsTableViewController
            newSupply2.key = key
            
        }
    }
    
    
}
