//
//  EditYourShindigViewController.swift
//  Shindig
//
//  Created by Emily Koagedal on 6/21/17.
//  Copyright © 2017 Ryann Consalo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EditYourShindigViewController: UIViewController {
    
    var key : String?

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBAction func backButton(_ sender: Any) {
        
        var reference : DatabaseReference! = Database.database().reference()
        reference?.child("Events").child(key!).child("date").setValue(dateTextField.text)
        reference?.child("Events").child(key!).child("location").setValue(locationTextField.text)
        reference?.child("Events").child(key!).child("time").setValue(timeTextField.text)
        reference?.child("Events").child(key!).child("price").setValue(priceTextField.text)
        reference?.child("Events").child(key!).child("details").setValue(descriptionTextField.text)
        //ref?.child("Events").child(key!).child("name").setValue(nameTextField.text)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref = Database.database().reference().child("Events").child(key!)
        var dat = ref.observe(.value, with: { (snapshot) in
            
            // If no supplies exist, display alert
            if !snapshot.exists() {
                let alertController = UIAlertController(title: "Error", message: " ", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
                
                
                // Put supplies in the supplies array
            else {
                print(snapshot)
                let dict1 = snapshot.value as! NSDictionary
                
                for (key, value) in dict1 {
                    if ((key as! String) == "date") {
                        self.dateTextField.text = value as! String
                    }
                    
                    if ((key as! String) == "details") {
                        self.descriptionTextField.text = value as! String
                    }
                    
                    if ((key as! String) == "location") {
                        self.locationTextField.text = value as! String
                    }
                    
                    /*if (key == "name") {
                     nameLable.text = value
                     }
                     */
                    
                    if ((key as! String) == "price") {
                        self.priceTextField.text = value as! String
                    }
                    
                    if ((key as! String) == "time") {
                        self.timeTextField.text = value as! String
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
