

//
//  AddShindigViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/20/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import CircleAnimatedMenu
import Firebase
import FirebaseDatabase
import Realm
import RealmSwift

class AddShindigViewController: UIViewController {
    
    var ref : DatabaseReference!
    //DatabaseReference? = Database.database().reference()
    
    var numSupplies = 0
    
    var key : String?
    
    @IBOutlet weak var shindigNameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var shindigDetailsTextView: UITextView!
    
    
    @IBAction func nextButton(_ sender: Any) {
        ref = Database.database().reference()
        key = ref?.childByAutoId().key
        ref?.child("Events").child(key!).child("date").setValue(dateTextField.text)
        ref?.child("Events").child(key!).child("location").setValue(locationTextField.text)
        ref?.child("Events").child(key!).child("time").setValue(timeTextField.text)
        ref?.child("Events").child(key!).child("price").setValue(priceTextField.text)
        ref?.child("Events").child(key!).child("details").setValue(shindigDetailsTextView.text)
        ref?.child("Events").child(key!).child("name").setValue(shindigNameTextField.text)
        ref?.child("Users").child(UserDefaults.standard.string(forKey: "Username")!).child("hosting").setValue(key!)
        
        let event = ShindigRealm()
        event.key = key
        event.name = shindigNameTextField.text
        
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        realm.add(event)
        do {
            try realm.commitWriteTransactionWithoutNotifying([])
        } catch {
            print("Error")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToSupplyList") {
            let add = segue.destination as! AddSuppliesTableViewController
            add.key = key
        }
        
        if (segue.identifier == "navToAddSupply") {
            let newSupply = segue.destination as! AddSupplyViewController
            newSupply.key = key
        }
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}



