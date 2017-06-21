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

    @IBOutlet weak var testMenu: CircleAnimatedMenu!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var shindigDetailsTextView: UITextView!
    
    @IBAction func doneButton(_ sender: Any) {
        ref = Database.database().reference()
        print("here")
        print(ref)
        
        var key = self.ref?.childByAutoId().key
        ref?.child("Events").child(key!).child("date").setValue(dateTextField.text)
        ref?.child("Events").child(key!).child("location").setValue(locationTextField.text)
        ref?.child("Events").child(key!).child("time").setValue(timeTextField.text)
        ref?.child("Events").child(key!).child("price").setValue(priceTextField.text)
        ref?.child("Events").child(key!).child("details").setValue(shindigDetailsTextView.text)
        print("added")
        
        let event = ShindigRealm()
        event.key = key
        
        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        realm.add(event)
        do {
            try realm.commitWriteTransactionWithoutNotifying([])
        } catch {
            print("Error")
        }
        print("realm")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        testMenu.imageSize = 40
        testMenu.outerRadius = 150
        testMenu.innerRadius = 50
        testMenu.closerBorderWidth = 0
        testMenu.menuWidthLine = 1
        testMenu.titleFont = UIFont.systemFont(ofSize: 14)
        testMenu.delegate = self as? CircleAnimatedMenuDelegate
        testMenu.highlightedColors = [.green, .yellow, .purple, .red, .brown]
        testMenu.tuplesArray = [("Facebook-1", "Facebook"), ("instagram-1", "Instagram"), ("Twitter", "Twitter"),
                                ("LinkedIn", "LinkedIn"), ("Google Plus +", "GooglePlus"), ("Pinterest", "Pinterest"),
                                ("RSS", "RSS"), ("YouTube", "YouTube"), ("Bloglovin", "Bloglovin"),
                                ("Emai", "Email"), ("Flickr", "Flickr"), ("github", "GitHub")]
        
        

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



